package MyAsserts;
use Carp;
use strict;
use warnings;
use utf8;
use Scalar::Util qw(looks_like_number);
use JSON;



use Exporter 5.57 'import';

our $VERSION     = '1.00';

our @EXPORT      = qw(user_assert);

sub is_int {
    my $str = $_[0];
    $str =~ s/^\s+|\s+$//g;

    if ($str =~ /^(\-|\+)?\d+?$/) {
        return 1;
    }
    else{
        return 0;
    }
}

sub user_assert
{
  my ($condition, $msg, $type) = @_;
  my $json = JSON->new;
  my ($pkg, $file, $line) = caller(0);
  open my $fh, "<", $file;
  my @lines = <$fh>;
  close $fh;
  my $caller_info = "$file:$line: " . $lines[$line - 1];
  if(!$condition)
  {
      my $data_to_json = {error=>"$msg",caller_info=>$caller_info,type=>$type};
      die $data_to_json;
  }
}



1;
