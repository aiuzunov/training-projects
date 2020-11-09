use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MyShop';
use MyShop::Controller::Checkout;

ok( request('/checkout')->is_success, 'Request should succeed' );
done_testing();
