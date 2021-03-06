#!C:/Strawberry/perl/bin/perl.exe

use strict;
use warnings;

# Given two DNA strands, return the locations from the second strand to the first

#Example:
#Dna1: GATATATGCATATACTT
#Dna2: ATAT
#Output: 2 4 10

my $dna1 = "AGTGTAACTCCCACGGCTGCCACGGCTACACTACCACGGCTCGCTAAACACGGCTCACGGCTCACGGCTCACGGCTGACACGGCTTACTACACGGCTGTCACGGCTTGGCCACGGCTCACTGAGCACGGCTTCACGGCTACTTCACGGCTACACGGCTTCCACGGCTCCACGGCTGCACGGCTCTCTACGAGTCCGTGCACGGCTCACGGCTCACGGCTTATAGGCTGCACGGCTCACGGCTAAAACGGCACGGCTCACGGCTAAATCATCACGGCTTCACGGCTGCTTCACGGCTACACGGCTTGAGATTCTCCACGGCTGGAGTCCTTAGCTACGACCGCTGTAGCACGGCTCCACACGGCTCACGGCTACACGGCTCGGGGCAATCCACGGCTACTAAACACTGCACGGCTACAACTGCCACGGCTACGCACGGCTGGGACACCCCACGGCTCACGGCTACAACACGGCTCACGGCTCACGGCTCACGGCTCGCACGGCTACTGTCACGGCTTCTGCACGGCTTCAGATAACACGGCTGCACGGCTCACGGCTGAGTGCACGGCTCACGGCTTGAACACGGCTTCAGCACGGCTTCACGGCTCACGGCTCCACGGCTACACGGCTCACGGCTCAGTCACGGCTCACGGCTCACACGGCTGCACGGCTCTTTCTTAGGCGAGCTATCACGGCTACACGGCTCACGGCTTAGCAACACGGCTTCCGACCGATGCACGGCTGTAGGGGCGCACGGCTGCATAGTCACGGCTAACTGGTACACGGCTCACGGCTCACGGCT";
my $dna2 = "CACGGCTCA";
my $dna2_length = length($dna2);
my ($locations, $position);

for (my $i = 0; $i < length($dna1); $i++) {
	my $substring = substr($dna1, $i, $dna2_length);
	if ($dna2 eq $substring) {
		$position = $i + 1;
		$locations .= $position . " ";
	}
}

$locations =~ s/\s+$//;

print $locations, "\n";
# 49 56 63 111 199 206 229 250 358 449 467 474 481 543 562 599 622 629 640 647 697 780 787