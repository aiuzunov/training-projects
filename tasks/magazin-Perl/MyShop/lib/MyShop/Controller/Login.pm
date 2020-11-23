package MyShop::Controller::Login;
use Moose;
use namespace::autoclean;
use warnings;
use strict;
use Try::Tiny;
use utf8;



BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MyShop::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

=head2 index

Login logic

=cut

sub index :Path :Args(0) {
    my ($self, $c) = @_;
    try
    {
      my $username = $c->request->params->{username};
      my $password = $c->request->params->{password};

      $c->logout();

      if ($username && $password) {
          if ($c->authenticate({ username => $username,
                                 password => $password,
                                 verified => 'true',} )) {
              $c->response->redirect($c->uri_for(
                  $c->controller('Books')->action_for('list')));
              return;
          } else {
              $c->stash(error_msg => "Грешно потребителско име или парола.");
          }
      } else {
          $c->stash(error_msg => "Грешно потребителско име или парола.")
              unless ($c->user_exists);
      }

      $c->stash(template => 'login/login.tt2');
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
