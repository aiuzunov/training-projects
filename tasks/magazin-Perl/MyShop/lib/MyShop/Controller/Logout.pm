package MyShop::Controller::Logout;
use Moose;
use namespace::autoclean;
use warnings;
use strict;
use Try::Tiny;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MyShop::Controller::Logout - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

=head2 index

Logout logic

=cut

sub index :Path :Args(0) {
    my ($self, $c) = @_;
    try
    {
      $c->logout();
      $c->response->redirect($c->uri_for('/'));
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
