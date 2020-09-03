#!/usr/bin/perl
use strict;


my @a;
while (<STDIN>) {
  /\S/ or last;
  push @a, $_;
}


print "Result:\n";
print reverse(@a);
