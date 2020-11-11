package MyShop::Controller::Root;
use Moose;
use namespace::autoclean;
use utf8;


BEGIN { extends 'Catalyst::Controller' }


__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

MyShop::Controller::Root - Root Controller for MyShop

=head1 DESCRIPTION


=head1 METHODS

=head2 index

The root page (/)

=cut
=head2 auto

Check if there is a user and, if not, forward to login page

=cut

sub auto :Private {
    my ($self, $c) = @_;


    if ($c->controller eq $c->controller('Login')) {
        return 1;
    }

    if (!$c->user_exists and $c->controller ne $c->controller('Admin')) {
        $c->log->debug('***Root::auto User not found, forwarding to /login');
        $c->response->redirect($c->uri_for('/login'));
        return 0;
    }

    return 1;
}

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    # Hello World
    $c->response->body( $c->welcome_message );
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
