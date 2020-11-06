package MyShop::Controller::Register;
use Moose;
use namespace::autoclean;

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
    $c->response->body('Matched MyShop::Controller::Register in Register.');
}

sub register_form :Local{
  my ( $self, $c ) = @_;

  $c->stash(template => 'register/register_form.tt2');

}

sub send_mail : Local {
    my ( $self, $c ) = @_;
    my $email = $c->req->param('email');
    my $name = $c->req->param('name');
    my $username =$c->req->param('username');
    my $password = $c->req->param('password');
    $c->model('DB::User')->create({
    name => $name,
    username => $username,
    email => $email,
    password => $password });

    $c->stash->{email} = {
        to      => $email,
        from    => 'aleksandar.i.uzunov@gmail.com',
        subject => 'Потвърждения на акаунта ви в gotiniqtmagazinzaknigi.com',
        body    => 'Привет, моля натиснете линка за да потвърдите вашият имейл адрес',
    };

    $c->forward( $c->view('Email') );
    $c->stash(template => 'register/send_mail.tt2',email => $email);

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
