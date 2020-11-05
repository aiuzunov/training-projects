package MyShop::Controller::Admin;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MyShop::Controller::Admin - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched MyShop::Controller::Admin in Admin.');
}

sub create :Local {

    my ($self, $c, $name, $image, $price,$count_in_stock,$description,$currency_id) = @_;

    my $book = $c->model('DB::Product')->create({
            name  => $name,
            image => $image,
            price => $price,
            count_in_stock => $count_in_stock,
            description => $description,
            currency_id => $currency_id,
        });

        # Store new model object in stash and set template
   $c->stash(book     => $book,
             template => 'admin/create.tt2');
    #TO-DO
}


sub delete :Local{
  my ($self, $c, $id) = @_;
  $c->stash(object => $c->model('DB::Product')->find($id));
    die "Book not found!" if !$c->stash->{object};

    $c->stash->{object}->delete;

    $c->stash->{status_msg} = "Book deleted.";

    #$c->forward('/admin/list');
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
