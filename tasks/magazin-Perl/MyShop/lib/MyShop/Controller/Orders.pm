package MyShop::Controller::Orders;
use Moose;
use namespace::autoclean;
use utf8;

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

    $c->response->body('Matched MyShop::Controller::Orders in Orders.');
}

sub select_address :Local{
  my ( $self, $c ) = @_;
  $c->stash(addresses => [$c->model('DB::Address')->search({user_id => $c->user->get('id')})]);
  $c->stash(template => 'orders/select_address.tt2');

}

sub create_order :Local{
  my ($self, $c) = @_;
  my $address = $c->req->param('address');
  my $cart = $c->session->{cart} || {};

  my $total = 0;
  my $storage = $c->model("DB::Product");

  my %items = map { $_ => $storage->find($_) } keys %$cart;

  $c->stash->{cart}{items} = \%items;
  $c->stash->{cart}{quantity} = $cart;

  foreach my $key (keys %items) {
      $total = $total + $c->stash->{cart}{quantity}{$key}*$c->stash->{cart}{items}{$key}->price;
  }
  my $order_info =
  {
   user_id => $c->user->get('id'),
   address_id => $address,
   order_status => 'Неплатена',
   currency => 'EUR',
   price => $total
  };
  my $my_order = $c->model('DB::Order')->create($order_info);

  foreach my $key (keys %items) {

      my $item = $c->model('DB::Product')->find($key);
      my $result = $item->get_column('count_in_stock') - $c->stash->{cart}{quantity}{$key};
      $item->update({count_in_stock => $result});
      $c->model('DB::OrderItem')->create({order_id => $my_order->get_column('id'),
      product_id => $key, quantity => $c->stash->{cart}{quantity}{$key}, product_price => $c->stash->{cart}{items}{$key}->price});
  }

  %{ $c->session->{cart} } = ();

  $c->stash(template => 'orders/order_created.tt2');
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
