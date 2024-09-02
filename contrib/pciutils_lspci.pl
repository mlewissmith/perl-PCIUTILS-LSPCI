#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);

use Data::Dumper;
$Data::Dumper::Sortkeys = 1;
$Data::Dumper::Terse = 1;
$Data::Dumper::Indent = 1;


use PCIUTILS::LSPCI;

my $obj = PCIUTILS::LSPCI->new;
my $lspci = $obj->get_lspci;

print Dumper $lspci;
