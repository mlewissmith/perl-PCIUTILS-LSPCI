package PCIUTILS::LSPCI;

# OO-PERL REFERENCES
# https://perldoc.perl.org/perlootut
# https://www.perl.com/article/25/2013/5/20/Old-School-Object-Oriented-Perl/

use strict;
use warnings;

our $VERSION = '1.0.0';

=head1 NAME

PCIUTILS::LSPCI - perl postprocess `lspci` output

=head1 SYNOPSIS

    use PCIUTILS::LSPCI;

    $obj = PCIUTILS::LSPCI->new;
    $lspci = $obj->get_lspci;

    ## Equivalent to `lspci -D -n`
    for $record (@$lspci) {
        $s = $record->{Slot};
        $v = $record->{Vendor};
        $d = $record->{Device};
        $c = $record->{Class};
        $r = $record->{Rev};
        print "$s $c: $v:$d";
        print " (rev $r)" if defined $r;
        print "\n";
    }

=head1 DESCRIPTION

Provide perl interface to PCI information as returned by B<lspci(1)>.

=cut

################################################################################
################################################################################
################################################################################
################################################################################

=head1 API

=head2 Methods

=over

=item B<< new >>

Constructor.  Build B<lspci> internal hash.

=cut

sub new {
    my ($class, $args) = @_;
    my $self = {
        lspci => undef,
    };
    my $blessed = bless $self, $class;

    $self->{lspci} = _lspci();

    return $blessed;
}

=item B<< get_lspci >>

Parsed output from C<lspci>, returned as arrayref:

Note: the B<lspci> hash is built at contruction time, see L</Internals>.

=cut

sub get_lspci {
    my $self = shift;
    return $self->{lspci};
}


=back

=cut

################################################################################
################################################################################
################################################################################
################################################################################

=head2 Internals

=over

=item B<< _lspci >>

Run C<< lspci -D -n -vmm >>, parse, return arrayref.

=cut

sub _lspci {
    my @devices = ();

    my %record = ();
    ## See lspci(1)
    ##  -vmm : machine-readable
    ##  -n   : vendor/device codes as numbers
    ##  -D   : show all domain numbers
    for my $line ( qx[lspci -D -n -vmm] ) {
        chomp $line;
        if (length($line)) {
            if ($line =~ m{^(\S+):\s*(\S+)\s*$}) {
                $record{$1} = $2;
            }
        } else {
            ## blank line terminates record
            push @devices, {%record};
            %record = ();
        }
    }
    return \@devices;
}

=back

=head1 SEE ALSO

B<< lspci(1) >>

=cut

1;
__END__
