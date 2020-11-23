package MyShop::Controller::Orders;
use Moose;
use namespace::autoclean;
use utf8;
use warnings;
use strict;
use Try::Tiny;

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
    $c->stash(addresses => [$c->model('DB::Address')->search({user_id => $c->user->get('id')})]);
    $c->stash(template => 'orders/select_address.tt2');
  }
  catch
  {
    $c->stash(error_msg =>  'Application Error!');
    $c->log->error($_);
  };
}

sub create_order :Local{
  my ($self, $c) = @_;
  try
  {
    my $address = $c->req->param('address');
    my $phone_number = $c->req->param('phone');
    my $first_name = $c->req->param('first_name');
    my $last_name = $c->req->param('last_name');
    my $payment_type = $c->req->param('payment_type');
    my $fullname = "$first_name $last_name";
    try
    {
    my $cart = $c->session->{cart} || {};

    my $total = 0;
    my $storage = $c->model("DB::Product");

    my %items = map { $_ => $storage->find({id_hash => $_}) } keys %$cart;

    $c->stash->{cart}{items} = \%items;
    $c->stash->{cart}{quantity} = $cart;

    foreach my $key (keys %items)
    {
        $total = $total + $c->stash->{cart}{quantity}{$key}*$c->stash->{cart}{items}{$key}->price;
    }
    my $order_info =
    {
     user_id => $c->user->get('id'),
     address_id => $address,
     order_status => 'Неплатена',
     currency => 'EUR',
     price => $total,
     phone_number => $phone_number,
     buyer_name => $fullname,
     payment_type => $payment_type,
    };
    my $my_order = $c->model('DB::Order')->create($order_info);

    foreach my $key (keys %items)
    {
        my $item = $c->model('DB::Product')->find({id_hash=>$key});
        my $result = $item->get_column('count_in_stock') - $c->stash->{cart}{quantity}{$key};
        $item->update({count_in_stock => $result});
        $c->model('DB::OrderItem')->create({order_id => $my_order->get_column('id'),
        product_id => $c->stash->{cart}{items}{$key}->id, quantity => $c->stash->{cart}{quantity}{$key}, product_price => $c->stash->{cart}{items}{$key}->price});
    }

    %{ $c->session->{cart} } = ();
    $c->stash(template => 'orders/order_created.tt2', payment_type => $payment_type, order_id => $my_order->get_column('id'));

    }
    catch
    {
      $c->stash(error_msg =>  'Application Error!');
      $c->log->error($_);
    };
  }
  catch
  {
    $c->stash(error_msg =>  'Application Error!');
    $c->log->error($_);
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
