package MyShop::View::HTML;
use Moose;
use namespace::autoclean;


extends 'Catalyst::View::TT';

__PACKAGE__->config(
  TEMPLATE_EXTENSION => '.tt2',
  INCLUDE_PATH => [
        MyShop->path_to( 'root', 'src' ),
    ],
  TIMER              => 0,
  ENCODING => 'utf-8',

  WRAPPER => 'wrapper.tt2',
);

=head1 NAME

MyShop::View::HTML - TT View for MyShop

=head1 DESCRIPTION

TT View for MyShop.

=head1 SEE ALSO

L<MyShop>

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
