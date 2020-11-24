package MyShop;
use Moose;
use namespace::autoclean;
use utf8;
use Catalyst qw/ Static::Simple /;
use Try::Tiny;

use Catalyst::Runtime 5.80;


# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    -Debug
    StatusMessage
    ConfigLoader
    Static::Simple
    Redirect
    Authorization::ACL
    Session
    Session::State::Cookie
    Session::Store::File
    Authentication
    Authorization::Roles
    StackTrace

/;

extends 'Catalyst';

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in myshop.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.
use Catalyst::Plugin::Unicode::Encoding;
__PACKAGE__->config( 'Plugin::Session' => {
    cookie_name => "my_fabulous_cookie",
    storage     => "/",
});
__PACKAGE__->config(
    'Plugin::Static::Simple' => {
        dirs => [
            'static',
            qr/^(images|css)/,
        ],
    },
    name => 'MyShop',
    disable_component_resolution_regex_fallback => 1,
    enable_catalyst_header => 1,
    default_view => 'HTML',
    encoding => 'UTF-8',
);
__PACKAGE__->config(
    'View::HTML' => {
        INCLUDE_PATH => [
            __PACKAGE__->path_to( 'root', 'src' ),
        ],
    },
    encoding => 'UTF-8',
);

__PACKAGE__->config(
    'Plugin::Authentication' => {

        default => {
            class           => 'SimpleDB',
            user_model      => 'DB::User',
            password_type   => 'self_check',

        },
        employees => {
            class           => 'SimpleDB',
            user_model      => 'DB::Employee',
            password_type   => 'self_check',
            role_relation => 'roles',
            role_field => 'name',
        },
    },
);

__PACKAGE__->config(
    'View::Email' => {
        stash_key => 'email',
        default => {
            content_type => 'text/plain',

            charset => 'utf-8'
        },

        sender => {

            mailer => 'SMTP',
            mailer_args => {
                host     => 'smtp.gmail.com',
                ssl      => 1,
                sasl_username => 'aleksandar.i.uzunov@gmail.com',
                sasl_password => '',
        }
      }
    }
);
# Start the application
__PACKAGE__->setup();
__PACKAGE__->deny_access_unless(
        "/admin/create",
        ['Create Products'],
    );
__PACKAGE__->deny_access_unless(
        "/admin/update",
        ['Update Products'],
    );
__PACKAGE__->deny_access_unless(
        "/admin/create_user",
        ['Create Users'],
    );

__PACKAGE__->deny_access_unless(
        "/admin/update_user",
        ['Update Users'],
    );

__PACKAGE__->deny_access_unless(
        "/admin/products",
        ['View Products'],
    );
__PACKAGE__->deny_access_unless(
        "/admin/users",
        ['View Users'],
  );
__PACKAGE__->deny_access_unless(
        "/admin/employees",
        ['View Employees'],
  );
__PACKAGE__->deny_access_unless(
        "/admin/create_employee",
        ['Create Employees'],
  );
__PACKAGE__->deny_access_unless(
        "/admin/update_employee",
        ['Update Employees'],
  );
__PACKAGE__->deny_access_unless(
        "/admin/user_stats",
        ['Справки'],
  );
__PACKAGE__->deny_access_unless(
        "/admin/order_stats",
        ['Справки'],
  );



=encoding utf8

=head1 NAME

MyShop - Catalyst based application

=head1 SYNOPSIS

    script/myshop_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<MyShop::Controller::Root>, L<Catalyst>

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
