print "Enter a number or 999 if you want to quit: ";
chomp($n = <STDIN>);
while ($n != 999) {
$sum += $n;
print "Enter another number or 999 if you want to quit: ";
chomp($n = <STDIN>);
}
print "The total sum is $sum\n";
