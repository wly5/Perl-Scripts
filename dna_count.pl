#!/usr/bin/perl

use strict;
use warnings;

# This Perl program takes in a DNA string, seq, of length up to 1000 nucleotides long
# Returns four integers counting the respective number of times that the symbols, A, C, G, T occur in seq

# Sample input: AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC
# Sample output: 20 12 17 21

my $A_count = 0;
my $C_count = 0;
my $G_count = 0;
my $T_count = 0;
my $seq = "TCCTTCCCGACCCCACTCAGTTTTAAAACAATCGTCGGGGAGTATTGTAGGCCTGGCATACCGAGATGTTCCCACGTGTCCCGAAGCATATCCTGAAGACCTGGCCGAGCACACGAGACGCATCAGGCTTGTCGACCATAGCATACGCTCAAGCAAGAGTGCGTGTCAGTCTCCAGGCAGAGAAATTGACCAAGCTTAGCACCACTGCGGGAGAATGACTCTAAGTGGTCCTTTTGCCACCACAATATATAGTCCCAATTCGTCACTTACATAATTTGAGTTAGTGCTCCGTTTCCGACATCAGCGCTGGCGCGCCGCCCCTGATTCGGAACGTATTACCTAGGGTACTGGTGAGCCAGTAAGCACAATCGAAGAAGTTAATAAGACCTTAACCCCGACTGTCGTGGTAATAACAAGTTATCGTACCCGCGTAAAGTCCTTTATCACATTTAAAGCTAGAGCCTTCATCGGGACAAGAAGGTCAGGGGGATCGTTTTATAGTGCGTATGCATTTCCAATGTGGCGCGACTTTCATTCTGAGAGTGAGCCATTTGTCACTCGCCAAGGCAACAGCCTCACGAGAGCCCACAACTTGTCTGCTACTTGCTCCTTCACCATGAGCTCCTGTTTGCCGAGGTTTAACGCATCTGAGATGACACGGCCTTTAGAACACCCTAGAAGTCACCTTCCGCCGTTCACTCCTCACCCACTCAGTCTCGGCCAGATGCTGGTTGGATCGTTAAGTGGATACGGCATCTTATACGTTCATCGTATGACTGTGAGTTAGTTAGTTTAGGTGTCACTCAGAATCGCACTGATACGCTGTATCGACAAGTTCAAGACAATTGGAAAAGATGTCTGAAGAAGGACGTTCGCTGAATGATCAAATCTCACTGGATTGTGCGTCCAAGGTTAAACCCATCCTTAATTTCGCGACCTCCAGGAATTATACCAGTCACAAAAGCGCACTTCTCGCATCACGATCCAAATATAA";
# Output: 261 261 221 251
my @seq_split = split //, $seq;

for (my $i = 0; $i < length($seq); $i++) {
   if ($seq_split[$i] eq 'A') {
      $A_count++;
   }
   if ($seq_split[$i] eq 'C') {
      $C_count++;
   }
   if ($seq_split[$i] eq 'G') {
      $G_count++;
   }
   if ($seq_split[$i] eq 'T') {
      $T_count++;
   }
}

print "$A_count $C_count $G_count $T_count\n";