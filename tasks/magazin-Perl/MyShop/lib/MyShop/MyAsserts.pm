package MyAsserts;

use strict;
use warnings;

use Exporter 5.57 'import';

our $VERSION     = '1.00';

our @EXPORT      = qw(user_assert);



sub user_assert {
  my ($type, $param, $ref) = @_;
  if($type eq "defined")
  {
    if(!defined $param)
    {
      my ($pkg, $file, $line) = caller(0);
      open my $fh, "<", $file;
      my @lines = <$fh>;
      close $fh;
      my $msg = "$file:$line: " . $lines[$line - 1];
      die "Assertion failed: $msg";
    }
  }
  elsif($type eq "ref")
  {
    if (ref($param) ne $ref)
    {
      my ($pkg, $file, $line) = caller(0);
      open my $fh, "<", $file;
      my @lines = <$fh>;
      close $fh;
      my $msg = "$file:$line: " . $lines[$line - 1];
      die "Assertion failed: $msg";
    }

  }
  else
  {
    if(!$param)
    {
      my ($pkg, $file, $line) = caller(0);
      open my $fh, "<", $file;
      my @lines = <$fh>;
      close $fh;
      my $msg = "$file:$line: " . $lines[$line - 1];
      die "Assertion failed: $msg";
    }

  }
}



1;
