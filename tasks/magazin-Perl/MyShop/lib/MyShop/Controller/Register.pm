package MyShop::Controller::Register;
use Moose;
use utf8;
use namespace::autoclean;
use String::Random;
use warnings;
use strict;
use Try::Tiny;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MyShop::Controller::Register - Catalyst Controller

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
      $c->response->body('Matched MyShop::Controller::Register in Register.');
    }
    catch
    {
      $c->stash(error_msg =>  'Application Error!');
      $c->log->error($_);
    };
}

sub register_form :Local{
  my ( $self, $c ) = @_;
  try
  {
    $c->stash(template => 'register/register_form.tt2');
  }
  catch
  {
    $c->stash(error_msg =>  'Application Error!');
    $c->log->error($_);
  };
}

sub send_mail : Local {
    my ( $self, $c ) = @_;
    try
    {
      my $string_gen = String::Random->new;
      my $email = $c->req->param('email');
      my $name = $c->req->param('name');
      my $username =$c->req->param('username');
      my $password = $c->req->param('password');
      try
      {
        my $code = $string_gen->randregex('[A-Z]{2}[a-z]{2}.[a-z]{2}\d'), "\n";



        $c->model('DB::EmailCode')->create({
        username => $username,
        email => $email,
        ver_code => $code });

        $c->model('DB::User')->create({
        name => $name,
        username => $username,
        email => $email,
        password => $password });

        $c->stash->{email} = {
            to      => $email,
            from    => 'aleksandar.i.uzunov@gmail.com',
            subject => 'Потвърждениe на акаунта ви в gotiniqtmagazinzaknigi.com',
            body    => "http://localhost:3000/register/verify/$code",
        };

        $c->forward( $c->view('Email') );
        $c->stash(template => 'register/send_mail.tt2',email => $email);
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

sub verify : Local {
  my ( $self, $c, $ver_code ) = @_;
  try
  {
    my $ver = $c->model('DB::EmailCode')->find($ver_code);
    my $email = $ver->email;
    $ver->delete();
    my $user = $c->model('DB::User')->search(email=>$email);
    $user->update({verified => 'true'});
    $c->stash(template => 'register/verify.tt2', email => $email);
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
