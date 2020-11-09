package MyShop::Model::PayPal;
use Moose;
use namespace::autoclean;
use parent 'Catalyst::Model::PayPal::API';




__PACKAGE__->config(
    Username   => 'sb-2aq3v2815957_api1.business.example.com',
    Password   => 'BK55YE8KXTJHSYA5',  ## supplied by PayPal
    Signature  => 'AHi5kCWjEq.udzx2AIUWZXBohPSqAud1MiHnF0Kj8FxZ8Ytc7MAqNdHz',     ## ditto
    sandbox    =>  1,    ## Use sandbox or production API
    subclasses => [qw(ExpressCheckout GetTransactionDetails )],
);

extends 'Catalyst::Model';


=head1 NAME

MyShop::Model::PayPal - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.


=encoding utf8

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
