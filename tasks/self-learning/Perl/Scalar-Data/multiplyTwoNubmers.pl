#!/usr/bin/perl
use IO::Prompt;

$first = prompt 'First Number:';
$second = prompt 'Second Number:';


$result = $first * $second;

print "Result of the multiplication: $result\n";
