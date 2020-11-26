package MyShop::Controller::Register;
use Moose;
use utf8;
use namespace::autoclean;
use String::Random;
use warnings;
use strict;
use Try::Tiny;
use DBI;
use lib qw(./Modules);
use MyAsserts;
use MyDBI;

our $dbh;
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
      $dbh = connect();
      assert(defined $dbh,"No connection to the database");

      $dbh->{AutoCommit} = 0;
      $dbh->{RaiseError} = 1;

      my $string_gen = String::Random->new;
      assert(defined $string_gen,'String Gen Failed');

      my $email = $c->req->param('email');
      assert(defined $email,'Required Param not defined');

      my $name = $c->req->param('name');
      assert(defined $name,'Required Param not defined');

      my $username =$c->req->param('username');
      assert(defined $username,'Required Param not defined');

      my $password = $c->req->param('password');
      assert(defined $password,'Required Param not defined');

      my $code = $string_gen->randregex('[A-Z]{2}[a-z]{2}.[a-z]{2}\d'), "\n";
      assert(defined $code,'Code gen failed');

      my $sth = $dbh->prepare("INSERT INTO email_codes
                              ( username,
                                email,
                                ver_code
                              )
                              VALUES(?,?,?)");

      $sth->execute($username,$email,$code);

      assert($sth->rows>0,"Грешка при записването на кода за потвърждение в базата");

      # $c->model('DB::EmailCode')->create({
      # username => $username,
      # email => $email,
      # ver_code => $code });

      my $sth = $dbh->prepare("INSERT INTO users
                              ( name,
                                username,
                                email,
                                password
                              )
                              VALUES(?,?,?,?)");

      $sth->execute($name,$username,$email,$password);

      assert($sth->rows>0,"Грешка при записването на потребителя в базата");
      #
      # $c->model('DB::User')->create({
      # name => $name,
      # username => $username,
      # email => $email,
      # password => $password });

      $c->stash->{email} = {
          to      => $email,
          from    => 'aleksandar.i.uzunov@gmail.com',
          subject => 'Потвърждениe на акаунта ви в gotiniqtmagazinzaknigi.com',
          body    => "http://localhost:3000/register/verify/$code",
      };
      $dbh->commit;
      $c->forward( $c->view('Email') );
      $c->stash(template => 'register/send_mail.tt2',email => $email);
    }
    catch
    {
      $c->stash(template => 'checkout/order_failed.tt2');
      try
      {
        $dbh->rollback;
      }
      catch
      {
        $c->stash(error_msg =>  "$_");
        $c->log->error("DB rollback failed: $_");
      };
      if(ref($_) eq "HASH")
      {
        my $error_type =$_->{type};
        if($error_type eq "user")
        {
          my $error_msg = $_->{error};
          my $caller_info = $_->{caller_info};
          $c->stash(error_msg =>  "$error_msg");
          $c->log->error("Error message: $error_msg, Caller Info: $caller_info");
        }
        elsif($error_type eq "internal")
        {
          my $error_msg = $_->{error};
          my $caller_info = $_->{caller_info};
          $c->stash(error_msg =>  "Application Error!");
          $c->log->error("Error message: $error_msg, Caller Info: $caller_info");
        }
        else
        {
          $c->stash(error_msg =>  "Application Error!");
          $c->log->error("$_");
        }

      }
      else
      {
        $c->stash(error_msg =>  "Application Error!");
        $c->log->error("$_");
      }
    };

}

sub verify : Local {
  my ( $self, $c, $ver_code ) = @_;
  try
  {
    assert(defined $ver_code,"Verification code is missing");
    $dbh = connect();
    assert(defined $dbh,"No connection to the database");
    $dbh->{AutoCommit} = 0;
    $dbh->{RaiseError} = 1;

    my $sth = $dbh->prepare("DELETE from email_codes where ver_code = ? RETURNING email");
    $sth->execute($ver_code);
    assert($sth->rows>0,"Неуспешно изтриване на кода за верификация");
    my $row = $sth->fetchrow_hashref;
    my $email = $row->{email};
    #
    # my $ver = $c->model('DB::EmailCode')->find($ver_code);
    # my $email = $ver->email;
    # $ver->delete();

    my $sth = $dbh->prepare("UPDATE users set verified='true' where email = ?");
    $sth->execute($email);
    assert($sth->rows>0,"Неуспешно потвърждаване на потребителя");

    # my $user = $c->model('DB::User')->search(email=>$email);
    # $user->update({verified => 'true'});
    $dbh->commit;
    $c->stash(template => 'register/verify.tt2', email => $email);
  }
  catch
  {
    $c->stash(template => 'checkout/order_failed.tt2');
    try
    {
      $dbh->rollback;
    }
    catch
    {
      $c->stash(error_msg =>  "$_");
      $c->log->error("DB rollback failed: $_");
    };
    if(ref($_) eq "HASH")
    {
      my $error_type =$_->{type};
      if($error_type eq "user")
      {
        my $error_msg = $_->{error};
        my $caller_info = $_->{caller_info};
        $c->stash(error_msg =>  "$error_msg");
        $c->log->error("Error message: $error_msg, Caller Info: $caller_info");
      }
      elsif($error_type eq "internal")
      {
        my $error_msg = $_->{error};
        my $caller_info = $_->{caller_info};
        $c->stash(error_msg =>  "Application Error!");
        $c->log->error("Error message: $error_msg, Caller Info: $caller_info");
      }
      else
      {
        $c->stash(error_msg =>  "Application Error!");
        $c->log->error("$_");
      }

    }
    else
    {
      $c->stash(error_msg =>  "Application Error!");
      $c->log->error("$_");
    }
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
