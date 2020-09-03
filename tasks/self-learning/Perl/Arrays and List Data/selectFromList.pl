#!/usr/bin/perl
use strict;
print "Please Enter The Position Of The Array To Be Printed:\n";

my $number = <>;
chomp($number);

my @a;
print "Enter The Strings You Want To Add To The Array /Exit With Ctrl+D/:\n";
while (<STDIN>) {
  /\S/ or last;
  push @a, $_;

}


print "Result:\n";
print @a[$number];
