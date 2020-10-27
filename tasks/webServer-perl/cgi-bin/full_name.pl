#!/usr/bin/perl
use CGI qw(:standard);
my $query = new CGI;

my $first_name = $query->param('first_name');
my $last_name = $query->param('last_name');



print "<h2>Hello, $first_name $last_name</h2>";


1;
