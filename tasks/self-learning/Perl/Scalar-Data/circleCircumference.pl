#!/usr/bin/perl

print "What is the radius of the circle?\n";
$radius = <>;
chomp($radius);

$circumference = $radius*2*3.141592654;

print "Circumference of the circle: $circumference\n";
