use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MyShop';
use MyShop::Controller::Cart;

ok( request('/cart')->is_success, 'Request should succeed' );
done_testing();
