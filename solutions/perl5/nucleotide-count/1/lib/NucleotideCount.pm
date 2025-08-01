package NucleotideCount;

# Dedicated to Shree DR.MDD

use strict;
use warnings;
use Carp;
use List::Util qw(reduce);
use Exporter 'import';
our @EXPORT_OK = qw(count_nucleotides);

sub count_nucleotides {
  my ($chain) = @_;
  croak "Invalid nucleotide in strand" if $chain =~ /[^AGCT]/;
  my $ledger = { A => 0, G => 0, C => 0, T => 0 };
  return reduce { $a->{$b}++, $a } $ledger, split //, $chain;
}

1;
