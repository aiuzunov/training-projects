use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MyShop';
use MyShop::Controller::Orders;

ok( request('/orders')->is_success, 'Request should succeed' );
done_testing();
