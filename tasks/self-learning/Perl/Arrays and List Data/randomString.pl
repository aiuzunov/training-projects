#!/usr/bin/perl
use strict;
srand;
my @a;
print "Enter The Strings You Want To Add To The Array /Exit With Ctrl+D/:\n";
while (<STDIN>) {
  /\S/ or last;
  push @a, $_;

}
my @random_array = (1... scalar @a);

print "Result:\n";
print @a[int rand(@random_array)];
