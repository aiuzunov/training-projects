package MyShop::Controller::Cart;
use Moose;
use namespace::autoclean;
use utf8;
use warnings;
use strict;
use Try::Tiny;



BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MyShop::Controller::Cart - Catalyst Controller

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
    $c->response->body('Matched MyShop::Controller::Cart in Cart.');
    }
    catch
    {
      $c->stash(error_msg =>  'Application Error!');
      $c->log->error($_);
    };
}

sub add : Local {
    my ( $self, $c, $item_id, $quantity ) = @_;
    try
    {
      $quantity ||= 1;
        if ( $c->stash(book => $c->model('DB::Product')->find({id_hash=>$item_id})))
        {
            $c->session->{cart}{$item_id} += $quantity;
            $c->stash(quantity => $quantity);
            $c->stash(status_msg => "Книгата беше успешно добавена във вашата количка с продукти!");
        }
        else
        {
            die "No such item";
        }
    }
    catch
    {
    $c->stash(error_msg =>  'Application Error!');
    $c->log->error($_);
    };

}

sub remove : Local {
    my ( $self, $c, $item_id) = @_;
    try
    {
      delete @{ $c->session->{cart} }{$item_id};
      $c->response->redirect($c->uri_for($self->action_for('list'),
       {mid => $c->set_status_msg("Продукта :беше успешно премахнат от вашата количка с продукти!")}));
     }
     catch
     {
     $c->stash(error_msg =>  'Application Error!');
     $c->log->error($_);
     };
}

sub empty_cart : Local {
    my ( $self, $c) = @_;
    try
    {
      %{ $c->session->{cart} } = ();
      $c->response->redirect($c->uri_for($self->action_for('list'),
       {mid => $c->set_status_msg("Успешно изпразнихте вашата количка с продукти!")}));
    }
    catch
    {
     $c->stash(error_msg =>  'Application Error!');
     $c->log->error($_);
   };
}

sub update :Local {
    my ($self, $c, $item_id) = @_;
    try{

    my $quantity = $c->request->params->{quantity} || '1';
    $c->session->{cart}{$item_id} = (quantity => $quantity);
    $c->response->redirect($c->uri_for($self->action_for('list'),
     {mid => $c->set_status_msg("Количеството на продукта беше успешно сменено на $quantity!")}));
    }
    catch
    {
      $c->stash(error_msg =>  'Application Error!');
      $c->log->error($_);
    };

}

sub list : Local {
    my ( $self, $c ) = @_;
    try
    {
      my $cart = $c->session->{cart} || {};

      my $storage = $c->model("DB::Product");

      my %items = map { $_ => $storage->find({id_hash => $_}) } keys %$cart;

      $c->stash->{cart}{items} = \%items;
      $c->stash->{cart}{quantity} = $cart;
      $c->load_status_msgs;
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
