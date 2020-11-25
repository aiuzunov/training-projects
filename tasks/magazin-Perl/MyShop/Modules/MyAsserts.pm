package MyAsserts;
use Carp;
use strict;
use warnings;
use utf8;
use Scalar::Util qw(looks_like_number);
use JSON;
use Data::Dumper;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(user_assert TRACE assert);


sub is_int {
    my $str = $_[0];
    $str =~ s/^\s+|\s+$//g;

    if ($str =~ /^(\-|\+)?\d+?$/)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

sub user_assert($$$)
{
  my ($condition, $code, $msg) = @_;
  my $json = JSON->new;
  my ($pkg, $file, $line) = caller(0);
  open my $fh, "<", $file;
  my @lines = <$fh>;
  close $fh;
  my $caller_info = "$file:$line: " . $lines[$line - 1];
  if(!$condition)
  {
      my $data_to_json = {error=>"[$code] $msg",caller_info=>$caller_info,type=>"user"};
      die $data_to_json;
  }
}

sub assert($$)
{
  my ($condition, $msg) = @_;
  my $json = JSON->new;
  my ($pkg, $file, $line) = caller(0);
  open my $fh, "<", $file;
  my @lines = <$fh>;
  close $fh;
  my $caller_info = "$file:$line: " . $lines[$line - 1];
  if(!$condition)
  {
      my $data_to_json = {error=>"$msg",caller_info=>$caller_info,type=>"internal"};
      die $data_to_json;
  }
}

sub TRACE(@)
{
  my (@params) = @_;
  my $length = @params;
  print STDERR "Starting TRACE\n";
  for(my $i=1;$i<=$length;$i++)
  {
    if(ref(\$params[$i-1]) ne "HASH")
    {
      print STDERR "$i: $params[$i-1]\n";
    }
    else
    {
      my $dumped_param = Dumper($params[$i-1]);
      print STDERR "$i: $dumped_param\n";
    }
  }
  print STDERR "Ending TRACE\n";
}


1;
