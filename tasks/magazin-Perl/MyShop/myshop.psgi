use strict;
use warnings;

use MyShop;

my $app = MyShop->apply_default_middlewares(MyShop->psgi_app);
$app;

