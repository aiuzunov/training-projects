use Business::PayPal::API::ExpressCheckout;
use Business::PayPal::API qw(GetTransactionDetails);
package MyShop::Controller::Checkout;
use Moose;
use namespace::autoclean;
use utf8;
use Data::Dumper;
use warnings;
use strict;
use Try::Tiny;
use Scalar::Util qw(looks_like_number);
use lib qw(./Modules);
use MyAsserts;
use MyDBI;

our $dbh;
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
  try
  {
    $dbh = connect();
    assert(defined $dbh,"No connection to the database");

    my $order_id = $c->req->param('order_id');
    assert(defined $order_id,"Order id is not defined");

    #  my $order = $c->model('DB::Order')->find($order_id);

    my $sth = $dbh->prepare("SELECT * from orders where id = ?");
    $sth->execute($order_id);
    assert($sth->rows>0,"Поръчката не е намерена");
    my $row = $sth->fetchrow_hashref;
    # my $order_id = $row->{id};
    my $currency_id = $row->{currency};
    my $total = $row->{price};
    my %resp = $pp->SetExpressCheckout(
                    OrderTotal => $total,
                    ReturnURL  => "http://localhost:3000/checkout/complete_checkout/$total/$order_id/$currency_id",
                    CancelURL  => 'http://localhost:3000/checkout/cancel',
                    currencyID => $currency_id
                    );
    assert(%resp,"Paypal did not respond");
    if( $resp{Ack} ne 'Success' )
    {
       for my $err ( @{$resp{Errors}} ) {
           warn "Error: " . $err->{LongMessage} . "\n";
       }
       die "PayPal error";
    }
    else
    {
      my $token = $resp{Token};
      $c->response->redirect("https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=$token");
    }
  }
  catch
  {
    $c->stash(template => 'checkout/order_failed.tt2');
    if(ref($_) eq "HASH")
    {
      my $error_type =$_->{type};
      if($error_type eq "user")
      {
        my $error_msg = $_->{error};
        my $caller_info = $_->{caller_info};
        $c->stash(error_msg =>  "$error_msg");
        $c->log->error("Error message: $error_msg, Caller Info: $caller_info");
      }
      elsif($error_type eq "internal")
      {
        my $error_msg = $_->{error};
        my $caller_info = $_->{caller_info};
        $c->stash(error_msg =>  "Application Error!");
        $c->log->error("Error message: $error_msg, Caller Info: $caller_info");
      }
      else
      {
        $c->stash(error_msg =>  "Application Error!");
        $c->log->error("$_");
      }

    }
    else
    {
      $c->stash(error_msg =>  "Application Error!");
      $c->log->error("$_");
    }
  };
}

sub complete_checkout :Local{
  my ( $self, $c, $total, $order_id, $currency_id ) = @_;
  try
  {
    $dbh = connect();
    assert(defined $dbh,"No connection to the database");
    $dbh->{AutoCommit} = 0;
    $dbh->{RaiseError} = 1;

    my $token = $c->request->param('token');
    my $payerID = $c->request->param('PayerID');

    assert(defined $total,"Required param is not defined");
    assert(defined $order_id,"Required param is not defined");
    assert(defined $currency_id,"Required param is not defined");
    assert(defined $token,"Required param is not defined");
    assert(defined $payerID,"Required param is not defined");


    my %details = $pp->GetExpressCheckoutDetails($token);
    assert(%details,"Paypal did not respond with details");


    my %payinfo = $pp->DoExpressCheckoutPayment( Token => $details{Token},
                                             PaymentAction => 'Sale',
                                             PayerID => $details{PayerID},
                                             OrderTotal => $total,
                                             currencyID => $currency_id
                                             );
    assert(%payinfo,"Paypal did not respond with information of the payment");

#    warn Dumper($payinfo{Errors}[0]);


    my %payment_info =
    (
     cancelled=>'false',
     paid=>'true',
     remote_payment_timestamp => $payinfo{PaymentDate},
     recipient_name => $details{Name},
     recipient_email => $details{Payer},
     payerid => $details{PayerID},
     paymentid => $payinfo{TransactionID},
     paymenttoken => $payinfo{Token},
     payment_sum => $payinfo{GrossAmount},
     currency => 'EUR',
     order_id => $order_id,
    );
    if($payinfo{Ack} eq 'Success')
    {
      my $sth = $dbh->prepare("UPDATE orders set order_status = 'Платена' where id = ?");
      $sth->execute($order_id);
      assert($sth->rows>0,"Неуспешно обновяване на поръчката");

      $sth = $dbh->prepare("INSERT INTO payments
                            (cancelled,
                             paid,
                             remote_payment_timestamp,
                             recipient_name,
                             recipient_email,
                             payerid,
                             paymentid,
                             paymenttoken,
                             payment_sum,
                             currency,
                             order_id)
                             VALUES (?,?,?,?,?,?,?,?,?,?,?)");

      $sth->execute('false',
                    'true',
                    $payment_info{remote_payment_timestamp},
                    $payment_info{recipient_name},
                    $payment_info{recipient_email},
                    $payment_info{payerid},
                    $payment_info{paymentid},
                    $payment_info{paymenttoken},
                    $payment_info{payment_sum},
                    $payment_info{currency},
                    $payment_info{order_id}
                    );
      assert($sth->rows>0,"Грешка при INSERT заявката за плащането");
      #$c->model('DB::Order')->find($order_id)->update({order_status => 'Платена'});

      #$c->model('DB::Payment')->create($payment_info);
      #warn map { "$_ => $payinfo{$_}\n" } keys %payinfo;
      $sth = $dbh->prepare("SELECT * from payments where order_id = ?");
      $sth->execute($order_id);
      assert($sth->rows>0,"Поръчката не е намерена");
      my $row = $sth->fetchrow_hashref;
      $c->stash(details => $row);
      # $c->stash(details => $c->model('DB::Payment')->find({order_id => $order_id}));
      $dbh->commit;
      $c->stash(template => 'checkout/order_finished.tt2');
    }
    else
    {
      die "Payment was not succesful";
    }

  }
  catch
  {
    $c->stash(template => 'checkout/order_failed.tt2');
    try
    {
      $dbh->rollback;
    }
    catch
    {
      $c->stash(error_msg =>  "$_");
      $c->log->error("DB rollback failed: $_");
    };
    if(ref($_) eq "HASH")
    {
      my $error_type =$_->{type};
      if($error_type eq "user")
      {
        my $error_msg = $_->{error};
        my $caller_info = $_->{caller_info};
        $c->stash(error_msg =>  "$error_msg");
        $c->log->error("Error message: $error_msg, Caller Info: $caller_info");
      }
      elsif($error_type eq "internal")
      {
        my $error_msg = $_->{error};
        my $caller_info = $_->{caller_info};
        $c->stash(error_msg =>  "Application Error!");
        $c->log->error("Error message: $error_msg, Caller Info: $caller_info");
      }
      else
      {
        $c->stash(error_msg =>  "Application Error!");
        $c->log->error("$_");
      }

    }
    else
    {
      $c->stash(error_msg =>  "Application Error!");
      $c->log->error("$_");
    }
  };
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
