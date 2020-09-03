#!/usr/bin/perl -l
use IO::Prompt;

$string = prompt 'String:';
$number = prompt 'Number:';

print "$string\n" x $number;
