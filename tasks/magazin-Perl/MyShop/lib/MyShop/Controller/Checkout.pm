use Business::PayPal::API::ExpressCheckout;
use Business::PayPal::API qw(GetTransactionDetails);
package MyShop::Controller::Checkout;
use Moose;
use namespace::autoclean;
use utf8;
use warnings;
use strict;


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

  my $order_id = $c->req->param('order_id');

  my $order = $c->model('DB::Order')->find($order_id);

  my $total = $order->get_column('price');

  my %resp = $pp->SetExpressCheckout(
                  OrderTotal => $total,
                  ReturnURL  => "http://localhost:3000/checkout/complete_checkout/$total/$order_id",
                  CancelURL  => 'http://localhost:3000/checkout/cancel'
                  );
  if( $resp{Ack} ne 'Success' )
  {
     for my $err ( @{$resp{Errors}} ) {
         warn "Error: " . $err->{LongMessage} . "\n";
     }
  }
  else
  {
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
  my ( $self, $c, $total, $order_id ) = @_;
  my $token = $c->request->param('token');
  my $payerID = $c->request->param('PayerID');


  warn $order_id, $total;


  my %details = $pp->GetExpressCheckoutDetails($token);


  my %payinfo = $pp->DoExpressCheckoutPayment( Token => $details{Token},
                                           PaymentAction => 'Sale',
                                           PayerID => $details{PayerID},
                                           OrderTotal => $total );

  warn map { "$_ => $payinfo{$_}\n" } keys %payinfo;


  my $payment_info =
  {
   cancelled=>'false',
   paid=>'true',
   time_of_payment => $payinfo{PaymentDate},
   recipient_name => $details{Name},
   recipient_email => $details{Payer},
   payerid => $details{PayerID},
   paymentid => $payinfo{TransactionID},
   paymenttoken => $payinfo{Token},
   payment_sum => $payinfo{GrossAmount},
   currency => 'EUR'
 };
  if($payinfo{Ack} eq 'Success')
  {
    $c->model('DB::Order')->find($order_id)->update({order_status => 'Платена'});
    $c->model('DB::Payment')->create($payment_info);
  }
  warn map { "$_ => $payinfo{$_}\n" } keys %payinfo;

  # else{
  #   my %transaction = $pp->GetTransactionDetails( TransactionID => $payinfo{TransactionID} );
  #   if($transaction{PaymentStatus} eq 'Completed'){
  #     $c->model('DB::Payment')->create($payment_info);
  #
  #     $c->model('DB::Order')->create($order_info);
  #   }else{
  #     my $p = Net::Ping->new("icmp");
  #     while (!$p->ping("8.8.4.4", 3)) {};
  #       my %transaction = $pp->GetTransactionDetails( TransactionID => 'EC-8WF99989E76845115' );
  #   }
  #
  # }

  $c->stash(template => 'checkout/order_finished.tt2', details => %payinfo);

}


sub test_details :Local{
  my ( $self, $c, $total ) = @_;
  my $p = Net::Ping->new("icmp");
  if ($p->ping("8.8.4.4", 10))
  {
    my %transaction = $pp->GetTransactionDetails( TransactionID => 'EC-8WF99989E76845115' );
    warn map { "$_ => $transaction{$_}\n" } keys %transaction;
  }
  else
  {
    warn "NO INTERNET CONNECTION";
  }

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
