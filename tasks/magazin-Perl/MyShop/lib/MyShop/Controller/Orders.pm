package MyShop::Controller::Orders;
use Moose;
use namespace::autoclean;
use utf8;
use warnings;
use strict;
use Try::Tiny;
use Data::Dumper;
use Scalar::Util qw(looks_like_number);
use lib qw(./Modules);
use MyAsserts;
use MyDBI;


our $dbh;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MyShop::Controller::Orders - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    try
    {
      $c->response->body('Matched MyShop::Controller::Orders in Orders.');
    }
    catch
    {
      $c->stash(error_msg =>  'Application Error!');
      $c->log->error($_);
    };
}

sub select_address :Local{
  my ( $self, $c ) = @_;
  try
  {
    $dbh = connect();
    assert(defined $dbh,"No connection to the database");
    my $sth = $dbh->prepare("SELECT * from addresses where user_id = ?");
    $sth->execute($c->user->get('id'));
    my @rows;
    while ( my $row = $sth->fetchrow_hashref ) {
        push @rows, $row;
    }
    $c->stash(addresses => [@rows]);
    # $c->stash(addresses => [$c->model('DB::Address')->search({user_id => $c->user->get('id')})]);
    $c->stash(template => 'orders/select_address.tt2');
  }
  catch
  {
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

sub create_order :Local{
  my ($self, $c) = @_;
  try
  {
    $dbh = connect();
    assert(defined $dbh,"No connection to the database");
    $dbh->{AutoCommit} = 0;
    $dbh->{RaiseError} = 1;

    my $address = $c->req->param('address');
    user_assert(length($address)<=50,"A643","Невалидни данни в полето за адрес");
    my $phone_number = $c->req->param('phone');
    user_assert(length($phone_number)==10,"A633","Невалидни данни в полето за телефон за връзка");
    my $first_name = $c->req->param('first_name');
    user_assert(!looks_like_number($first_name),"C443","Невалидни данни в полето за първо име");
    my $last_name = $c->req->param('last_name');
    user_assert(!looks_like_number($last_name),"C543","Невалидни данни в полето за фамилно име");
    my $payment_type = $c->req->param('payment_type');
    user_assert(!looks_like_number($payment_type),"C763","Невалидни данни в полето за тип на плащането");

    my $fullname = "$first_name $last_name";
    my $cart = $c->session->{cart} || {};

    my $total = 0;
    assert($total==0,"Първоначалната стойност на total не е равна на 0");
    my $storage = $c->model("DB::Product");

    my %items = map { $_ => $storage->find({id_hash => $_}) } keys %$cart;

    $c->stash->{cart}{items} = \%items;
    $c->stash->{cart}{quantity} = $cart;

    foreach my $key (keys %items)
    {
        $total = $total + $c->stash->{cart}{quantity}{$key}*$c->stash->{cart}{items}{$key}->price;
    }
    my %order_info =
    (
     user_id => $c->user->get('id'),
     address_id => $address,
     order_status => 'Неплатена',
     currency => 'EUR',
     price => $total,
     phone_number => $phone_number,
     buyer_name => $fullname,
     payment_type => $payment_type,
    );
    # my $my_order = $c->model('DB::Order')->create($order_info);
    my $sth = $dbh->prepare("INSERT INTO ORDERS
                            ( user_id,
                              address_id,
                              order_status,
                              currency,
                              price,
                              phone_number,
                              buyer_name,
                              payment_type)
                              VALUES(?,?,?,?,?,?,?,?)
                              RETURNING id");
    TRACE($order_info{address_id},"TESt");

    $sth->execute($order_info{user_id},
                  $order_info{address_id},
                  $order_info{order_status},
                  $order_info{currency},
                  $order_info{price},
                  $order_info{phone_number},
                  $order_info{buyer_name},
                  $order_info{payment_type});

    assert($sth->rows>0,"Грешка при създаването на поръчка");

    my $row = $sth->fetchrow_hashref;
    my $order_id = $row->{id};
    foreach my $key (keys %items)
    {
      $sth = $dbh->prepare("select * from products where id_hash = ?");
      $sth->execute($key);
      assert($sth->rows>0,"Несъществуващ продукт");

      $row = $sth->fetchrow_hashref;
        # my $item = $c->model('DB::Product')->find({id_hash=>$key});
      my $result =  $row->{count_in_stock} - $c->stash->{cart}{quantity}{$key};
      $sth = $dbh->prepare("update products set count_in_stock = ? where id_hash=?");
      $sth->execute($result, $key);
      assert($sth->rows>0,"Грешка при обновяването на продукта");

      #$item->update({count_in_stock => $result});
      my $sth = $dbh->prepare("INSERT INTO order_items
                              ( order_id,
                                product_id,
                                quantity,
                                product_price
                              )
                              VALUES(?,?,?,?)");
      $sth->execute($order_id,
                    $c->stash->{cart}{items}{$key}->id,
                    $c->stash->{cart}{quantity}{$key},
                    $c->stash->{cart}{items}{$key}->price
                   );
      assert($sth->rows>0,"Грешка при създаването на order_item");
      #$c->model('DB::OrderItem')->create({order_id => $order_id ,
      #product_id => $c->stash->{cart}{items}{$key}->id, quantity => $c->stash->{cart}{quantity}{$key}, product_price => $c->stash->{cart}{items}{$key}->price});
    }
    $dbh->commit;
    %{ $c->session->{cart} } = ();
    $c->stash(template => 'orders/order_created.tt2', payment_type => $payment_type, order_id => $order_id);
  }
  catch
  {
    $c->stash(template => 'orders/select_address.tt2');
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
