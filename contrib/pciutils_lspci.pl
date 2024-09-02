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

## Equivalent to `lspci -D -n`
for my $record (@$lspci) {
    my $s = $record->{Slot};
    my $v = $record->{Vendor};
    my $d = $record->{Device};
    my $c = $record->{Class};
    my $r = $record->{Rev};
    print "$s $c: $v:$d";
    print " (rev $r)" if defined $r;
    print "\n";
}
