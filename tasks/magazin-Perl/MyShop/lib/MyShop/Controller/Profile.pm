package MyShop::Controller::Profile;
use Moose;
use Scalar::Util qw(looks_like_number);
use utf8;
use namespace::autoclean;
use warnings;
use strict;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MyShop::Controller::Profile - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash(template => 'profile/profile.tt2');
}

sub orders :Local{
  my ($self, $c) = @_;
  my $page = $c->req->param('page');

  if(!looks_like_number($page)){
  $page = 1;
  }
  warn $c->user->get('id');
  $c->stash(orders => [$c->model('DB::Order')->search({user_id => $c->user->get('id')}, {
         page => $page,
         rows => 10,
         join      => {'order_items'=>'product','user'},
         order_by => {-asc => 'id'},
         group_by => 'id',


    })]);


  $c->stash(template => 'profile/orders.tt2',page => $page);

  }

  sub add_address :Local {
    my ($self, $c) = @_;
    my $address = $c->req->param('address');
    my $city = $c->req->param('city');
    my $postal_code = $c->req->param('postal_code');
    my $country = $c->req->param('country');

    my $address_info =
    {
     user_id => $c->user->get('id'),
     address => $address,
     city => $city,
     postalcode => $postal_code,
     country => $country,
   };
    $c->model('DB::Address')->create($address_info);

    $c->response->redirect($c->uri_for('/profile'));
  }
  sub address_form :Local {
    my ($self, $c) = @_;
    $c->stash->{template} = 'profile/address_form.tt2';
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
