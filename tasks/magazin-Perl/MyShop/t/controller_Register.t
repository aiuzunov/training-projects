use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MyShop';
use MyShop::Controller::Register;

ok( request('/register')->is_success, 'Request should succeed' );
done_testing();
