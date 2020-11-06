package MyShop::View::Email;

use strict;
use base 'Catalyst::View::Email';

__PACKAGE__->config(
    stash_key => 'email'
);

=head1 NAME

MyShop::View::Email - Email View for MyShop

=head1 DESCRIPTION

View for sending email from MyShop. 

=head1 AUTHOR

root

=head1 SEE ALSO

L<MyShop>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
