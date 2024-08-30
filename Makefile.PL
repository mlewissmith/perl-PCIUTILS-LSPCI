# MAKEMAKER REFERENCES
# https://metacpan.org/pod/ExtUtils::MakeMaker
# https://metacpan.org/pod/ExtUtils::MakeMaker::Tutorial
# https://metacpan.org/pod/ExtUtils::Manifest


use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'PCIUTILS::LSPCI',
    AUTHOR              => 'Magnus Lewis-Smith <ccsgac@csc.warwick.ac.uk>',
    VERSION_FROM        => 'lib/PCIUTILS/LSPCI.pm',
    ABSTRACT_FROM       => 'lib/PCIUTILS/LSPCI.pm',
    LICENSE             => 'unrestricted',
    EXE_FILES           => [ glob "./bin/*" ],
);
