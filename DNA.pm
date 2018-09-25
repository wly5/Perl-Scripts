package DNA;
use strict;
use warnings;

# Rna Transcription

# Given a DNA strand, return its RNA complement (per RNA transcription).

sub to_rna {
  my ($DNAseq) = @_;
  my $RNAseq = $DNAseq;
  $RNAseq =~ tr/GCTA/CGAU/;
  return $RNAseq;
}

1;
