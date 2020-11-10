use Business::PayPal::API::ExpressCheckout;
package MyShop::Controller::Checkout;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MyShop::Controller::Checkout - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

my $pp = Business::PayPal::API::ExpressCheckout->new(Username => 'sb-2aq3v2815957_api1.business.example.com',
Password => 'BK55YE8KXTJHSYA5',
Signature =>'AHi5kCWjEq.udzx2AIUWZXBohPSqAud1MiHnF0Kj8FxZ8Ytc7MAqNdHz',
sandbox => 1);

=head2 index

=cut

sub index :Path :Args(0) {
  my ( $self, $c, @args ) = @_;

  my $cart = $c->session->{cart} || {};

  my $total = 0;
  my $storage = $c->model("DB::Product");

  my %items = map { $_ => $storage->find($_) } keys %$cart;

  $c->stash->{cart}{items} = \%items;
  $c->stash->{cart}{quantity} = $cart;

  foreach my $key (keys %items) {
      $total = $total + $c->stash->{cart}{quantity}{$key}*$c->stash->{cart}{items}{$key}->price;
  }

  # my $pp = Business::PayPal::API::ExpressCheckout->new(Username => 'sb-2aq3v2815957_api1.business.example.com',
  # Password => 'BK55YE8KXTJHSYA5',
  # Signature =>'AHi5kCWjEq.udzx2AIUWZXBohPSqAud1MiHnF0Kj8FxZ8Ytc7MAqNdHz',
  # sandbox => 1);


  my %resp = $pp->SetExpressCheckout(
                  OrderTotal => $total,
                  ReturnURL  => "http://localhost:3000/checkout/complete_checkout/$total",
                  CancelURL  => 'http://localhost:3000/checkout/cancel'
                  );
  if( $resp{Ack} ne 'Success' ) {
     for my $err ( @{$resp{Errors}} ) {
         warn "Error: " . $err->{LongMessage} . "\n";
     }
  }else{
    my $token = $resp{Token};
    $c->response->redirect("https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=$token");
    my %details = $pp->GetExpressCheckoutDetails($token);
    my %payinfo = $pp->DoExpressCheckoutPayment( Token => $details{Token},
                                             PaymentAction => 'Sale',
                                             PayerID => $details{PayerID},
                                             OrderTotal => $total );

  }


}

sub complete_checkout :Local{
  my ( $self, $c, $total ) = @_;
  my $token = $c->request->param('token');
  my $payerID = $c->request->param('PayerID');

  my %details = $pp->GetExpressCheckoutDetails($token);


  my %payinfo = $pp->DoExpressCheckoutPayment( Token => $details{Token},
                                           PaymentAction => 'Sale',
                                           PayerID => $details{PayerID},
                                           OrderTotal => $total );
  warn map { "$_ => $payinfo{$_}\n" } keys %payinfo;

  $c->stash(template => 'checkout/complete_checkout.tt2', details => %payinfo);

}









=encoding utf8

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
