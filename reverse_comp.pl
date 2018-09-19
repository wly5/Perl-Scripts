#!/usr/bin/perl

use strict;
use warnings;

# Perl program that takes the reverse complement of a DNA sequence
# The new sequence is formed by first reversing the DNA sequence, and taking the complement of each base
# A always complements with T
# C always complements with G


# Sample input: AAAACCCGGT
# Sample output: ACCGGGTTTT

my $DNA_seq = "TCGCGGTAGGAATACACTACACTACCACGGAATTACCAAGCTATTCGAACTACAGATAGGCATTCCATATGTAATTGAGTGACCATGGGGAGATTGGTCGGTCCCTGGTGAAATACTAGCTTCATATGGTAGACTTCTCATACGATTACGGCAGCATTTTGCACGGTTGTTCTGCCAGACGATGCCTTGTGTCAGTTATTTTCGGCGGAGCTTACTGCAGTGCTACCGGTCCGTACTTCAGTGACTCCCGCATTTGATGACTCCAAATCGCCAAAGGTAAGTTACACCTAGAGGCAACACGTGGCCCGGGTCCTCCACCTGAGGTTGCGCTTTCATGGAGGAGAGCCTTTATGGATTAAACCCTAACCGAACGGGCGCATCGTTACATACGCTGATATCAGTAAAGGAAACCCCCAAAACAAATCTGGACCACGGTTCTTGATGCACCCCGTTCATAGCCATCTGCAAACCTGTTTAACGTCTTAGTCGAAGCGTGTACTTCCCTGGTTCTGGTACACACATCTTTGGTATACCAACCTCATAAACACATCGGCTAACGGAGAATTTTTGGGGTTAGAATCCGCGTGCGATCCACAAGGCGGCCCGAATCGGGCTGTGGGAATTCGAAGGCCACTGAGCTCGAGAGCCCCAAATACGTACATATCTATATAGTATGGACGTACTCTAGCTTATCTCGTGTACCCTCACCAAGGCGAGCATAGTGTAGTTCCCTCTTGATGGGACGCCTCGACTTATCTGCAGATTGGCCTTAGTTCAGTACCAACTTACGTACAGGGTGCTTCGGCTCGGACGCTC";
$DNA_seq = reverse $DNA_seq;
#print "$DNA_seq\n";
$DNA_seq =~ tr/ACGT/TGCA/;
print "$DNA_seq\n";

# Output: GAGCGTCCGAGCCGAAGCACCCTGTACGTAAGTTGGTACTGAACTAAGGCCAATCTGCAGATAAGTCGAGGCGTCCCATCAAGAGGGAACTACACTATGCTCGCCTTGGTGAGGGTACACGAGATAAGCTAGAGTACGTCCATACTATATAGATATGTACGTATTTGGGGCTCTCGAGCTCAGTGGCCTTCGAATTCCCACAGCCCGATTCGGGCCGCCTTGTGGATCGCACGCGGATTCTAACCCCAAAAATTCTCCGTTAGCCGATGTGTTTATGAGGTTGGTATACCAAAGATGTGTGTACCAGAACCAGGGAAGTACACGCTTCGACTAAGACGTTAAACAGGTTTGCAGATGGCTATGAACGGGGTGCATCAAGAACCGTGGTCCAGATTTGTTTTGGGGGTTTCCTTTACTGATATCAGCGTATGTAACGATGCGCCCGTTCGGTTAGGGTTTAATCCATAAAGGCTCTCCTCCATGAAAGCGCAACCTCAGGTGGAGGACCCGGGCCACGTGTTGCCTCTAGGTGTAACTTACCTTTGGCGATTTGGAGTCATCAAATGCGGGAGTCACTGAAGTACGGACCGGTAGCACTGCAGTAAGCTCCGCCGAAAATAACTGACACAAGGCATCGTCTGGCAGAACAACCGTGCAAAATGCTGCCGTAATCGTATGAGAAGTCTACCATATGAAGCTAGTATTTCACCAGGGACCGACCAATCTCCCCATGGTCACTCAATTACATATGGAATGCCTATCTGTAGTTCGAATAGCTTGGTAATTCCGTGGTAGTGTAGTGTATTCCTACCGCGA