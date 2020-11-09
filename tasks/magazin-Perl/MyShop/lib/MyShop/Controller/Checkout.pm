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


=head2 index

=cut

sub index :Path :Args(0) {
  my ( $self, $c, @args ) = @_;

my $pp = Business::PayPal::API::ExpressCheckout->new(Username => 'sb-2aq3v2815957_api1.business.example.com',
  Password => 'BK55YE8KXTJHSYA5',
  Signature =>'AHi5kCWjEq.udzx2AIUWZXBohPSqAud1MiHnF0Kj8FxZ8Ytc7MAqNdHz',
  sandbox => 1);

  my $cart = $c->session->{cart} || {};

  my $storage = $c->model("DB::Product");

  my %items = map { $_ => $storage->find($_) } keys %$cart;

  my $value_count = 0;
  $value_count += $items{price};
  warn $value_count;


my %resp = $pp->SetExpressCheckout( OrderTotal => '55.43');
if( $resp{Ack} ne 'Success' ) {
   for my $err ( @{$resp{Errors}} ) {
       warn "Error: " . $err->{LongMessage} . "\n";
   }
}else{
  my $token = $resp{Token};
  $c->response->redirect("https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=$token");
}

}







sub test :Local {
  my ( $self, $c, @args ) = @_;

  my $cart = $c->session->{cart} || {};

  my $storage = $c->model("DB::Product");

  my %items = map { $_ => $storage->find($_) } keys %$cart;
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
