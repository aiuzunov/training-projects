use CGI qw(:standard);
my $query = new CGI;

$sum = 0;
%hash = $query->Vars();
$string = "The sum of ";

foreach $key (keys %hash) {
    $string = $string.$hash{$key}." + ";
    $sum = $sum + $hash{$key};
}
$s = substr $string, 0, -3;
print($s." = ".$sum);
