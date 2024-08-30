package PCIUTILS::LSPCI;

# OO-PERL REFERENCES
# https://perldoc.perl.org/perlootut
# https://www.perl.com/article/25/2013/5/20/Old-School-Object-Oriented-Perl/

use strict;
use warnings;

our $VERSION = '0.0.1';

=head1 NAME

PCIUTILS::LSPCI - perl postprocess `lspci` output

=head1 SYNOPSIS

    use PCIUTILS::LSPCI;

    my $obj = PCIUTILS::LSPCI->new;
    my $lspci = $obj->get_lspci;

    for my $device ( sort keys %$lspci ) {
        ...
    }

=head1 DESCRIPTION

TBD

=cut

################################################################################
################################################################################
################################################################################
################################################################################

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

Parsed output from C<lspci -n -vmm>, returned as hashref:

    {
        'HEX:HEX' => [ { 'tag' => 'value' }, ... ]
    }

Note: primary key is C<< $pcivendor:$pcidevice >> containg array of B<< lspci >>
tag:value pairs, one per device installed.

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

Run C<< lspci -vmm -n >>, parse, return hashref.

=cut

sub _lspci {
    my %devices = ();
    my %device = ();
    for my $line ( qx[lspci -vmm -n] ) {
        chomp $line;
        if (length($line)) {
            if ($line =~ m{^(\S+):\s*(\S+)\s*$}) {
                $device{$1} = $2;
            }
        } else {
            ## blank line terminates record
            push @{ $devices{"$device{Vendor}:$device{Device}"} }, {%device};
            %device = ();
        }
    }
    return \%devices;
}

=back

=cut

1;
__END__
