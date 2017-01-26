#!/usr/bin/env perl
use strict;
use warnings;
use Archive::Zip;
use Encode;

if (@ARGV != 1) {
  die "usage: $0 ZIPFILE\n";
}
my $zipfile = shift;
if (! -e $zipfile) {
  die "$zipfile don't exist\n";
} 
my $zip=Archive::Zip->new($zipfile);
my @items = $zip->memberNames();
my $utf8name;
foreach (@items) {
  my $utf8name = $_;
  Encode::from_to($utf8name, 'cp932', 'utf-8');
  print "extract : $utf8name\n";
  $zip->extractMember($_, $utf8name);
}
