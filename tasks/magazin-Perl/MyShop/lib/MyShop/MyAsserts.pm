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

sub user_assert {
  my ($type, $param, $ref, $field) = @_;
  my $json = JSON->new;
  my ($pkg, $file, $line) = caller(0);
  open my $fh, "<", $file;
  my @lines = <$fh>;
  close $fh;
  my $caller_info = "$file:$line: " . $lines[$line - 1];
  if($type eq "defined")
  {
    if(!defined $param)
    {
      my $data_to_json = {error=>"The given parameter is not defined",caller_info=>$caller_info};
      die $data_to_json;
    }
  }
  elsif($type eq "ref")
  {
    if (ref($param) ne $ref)
    {
      my $data_to_json = {error=>"Assertion failed: the given parameter is not of type $ref.",caller_info=>$caller_info};
      die $data_to_json;
    }

  }
  elsif($type eq "scalar_type")
  {
      if($ref eq "string" && looks_like_number($param))
      {
        my $data_to_json = {error=>"Невалидни данни в полето: '$field'",caller_info=>$caller_info};
        die $data_to_json;
      }
      elsif($ref eq "number" && !looks_like_number($param))
      {
        my $data_to_json = {error=>"Невалидни данни в полето: '$field'",caller_info=>$caller_info};
        die $data_to_json;      }
      elsif($ref eq "integer" && !(is_int($param)))
      {
        my $data_to_json = {error=>"Невалидни данни в полето: '$field'",caller_info=>$caller_info};
        die $data_to_json;
      }
  }
  else
  {
    if(!$param)
    {
      my $data_to_json = {error=>"$param is false:",caller_info=>$caller_info};
      die $data_to_json;
    }
  }
}



1;
