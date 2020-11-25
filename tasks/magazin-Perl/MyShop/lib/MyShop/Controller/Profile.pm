package MyShop::Controller::Profile;
use Moose;
use Scalar::Util qw(looks_like_number);
use utf8;
use namespace::autoclean;
use warnings;
use strict;
use Try::Tiny;

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
  try
  {
    my $dbh = DBI->connect('dbi:Pg:dbname=onlineshop', 'shopadmin', '1234', {AutoCommit => 1}) or die $DBI::errstr;

    my $page = $c->req->param('page');

    if(!looks_like_number($page)){
    $page = 1;
    }
    try
    {
        my $offset = ($page-1)*10;

        my $sth = $dbh->prepare("SELECT o.id,
                                o.user_id,
                                o.address_id,
                                to_char(o.created, 'yyyy-mm-dd hh24:mi:ss') as created,
                                o.order_status,
                                o.price,
                                o.currency,
                                o.phone_number,
                                o.buyer_name,
                                o.payment_type,
                                u.name as name,
                                u.email as email,
                                to_char(pa.payment_timestamp, 'yyyy-mm-dd hh24:mi:ss') as payment_date,
                                array_agg(' [ ' || p.name || ': ' || oi.quantity || 'бр' || ' Цена: ' || oi.product_price*oi.quantity || ' ' || o.currency  || ' ] ') as producterinos
                                FROM orders o
                                left join payments pa on pa.order_id = o.id
                                join order_items oi on oi.order_id = o.id
                                join products p on oi.product_id = p.id
                                join users u on o.user_id = u.id
                                where o.user_id = ?
                                group by o.id,u.name,u.email,payment_date
                                order by o.order_status,o.id desc
                                LIMIT 10 OFFSET ?");

        $sth->execute($c->user->get('id'),$offset);
        my @rows;
        while ( my $row = $sth->fetchrow_hashref )
        {
            push @rows, $row;
        }
        $c->stash(orders => [@rows]);
      # $c->stash(orders => [$c->model('DB::Order')->search({user_id => $c->user->get('id')}, {
      #        page => $page,
      #        rows => 10,
      #        order_by => {-asc => 'order_status'},
      #        group_by => 'id',
      #   })]);

    }
    catch
    {
      $c->stash(error_msg =>  'Application Error!');
      $c->log->error($_);
    };

    $c->stash(template => 'profile/orders.tt2',page => $page);
  }
  catch
  {
    $c->stash(error_msg =>  'Application Error!');
    $c->log->error($_);
  };
}

  sub add_address :Local {
    my ($self, $c) = @_;
    try
    {
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
    catch
    {
      $c->stash(error_msg =>  'Application Error!');
      $c->log->error($_);
    };
  }
  sub address_form :Local {
    my ($self, $c) = @_;
    try
    {
      $c->stash->{template} = 'profile/address_form.tt2';
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
