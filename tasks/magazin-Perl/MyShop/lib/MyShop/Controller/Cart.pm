package MyShop::Controller::Cart;
use Moose;
use namespace::autoclean;
use utf8;


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

    $c->response->body('Matched MyShop::Controller::Cart in Cart.');
}

sub add : Local {
    my ( $self, $c, $item_id, $quantity ) = @_;
    $quantity ||= 1;
    if ( $c->stash(book => $c->model('DB::Product')->find($item_id))) {
        $c->session->{cart}{$item_id} += $quantity;
        $c->stash(quantity => $quantity);
        $c->stash(status_msg => "Книгата беше успешно добавена във вашата количка с продукти!");


    } else {
        die "No such item";
    }
}

sub remove : Local {
    my ( $self, $c, $item_id) = @_;

    delete @{ $c->session->{cart} }{$item_id};
    $c->response->redirect($c->uri_for($self->action_for('list'),
     {mid => $c->set_status_msg("Продукта с ID:$item_id беше успешно премахнат от вашата количка с продукти!")}));
}

sub empty_cart : Local {
    my ( $self, $c) = @_;
    %{ $c->session->{cart} } = ();
    $c->response->redirect($c->uri_for($self->action_for('list'),
     {mid => $c->set_status_msg("Успешно изпразнихте вашата количка с продукти!")}));
}

sub update :Local {
    my ($self, $c, $item_id) = @_;
    my $quantity = $c->request->params->{quantity} || '1';

    $c->session->{cart}{$item_id} = (quantity => $quantity);
    $c->response->redirect($c->uri_for($self->action_for('list'),
     {mid => $c->set_status_msg("Количеството на продукта с ID:$item_id беше успешно сменено на $quantity!")}));


}

sub list : Local {
    my ( $self, $c ) = @_;

    my $cart = $c->session->{cart} || {};

    my $storage = $c->model("DB::Product");

    my %items = map { $_ => $storage->find($_) } keys %$cart;

    $c->stash->{cart}{items} = \%items;
    $c->stash->{cart}{quantity} = $cart;
    $c->load_status_msgs;
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
