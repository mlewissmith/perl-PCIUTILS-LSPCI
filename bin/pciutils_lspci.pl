#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);

use Data::Dumper;

use PCIUTILS::LSPCI;

my $obj = PCIUTILS::LSPCI->new;
my $lspci = $obj->get_lspci;

for my $device ( sort keys %$lspci ) {
    say "[$device]";
}
