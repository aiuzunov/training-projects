use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MyShop';
use MyShop::Controller::Profile;

ok( request('/profile')->is_success, 'Request should succeed' );
done_testing();
