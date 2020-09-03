#!/usr/bin/perl
use IO::Prompt;

$radius = prompt 'Radius:';
$circumference = $radius*2*3.141592654;

print "Circumference of the circle: $circumference\n";
