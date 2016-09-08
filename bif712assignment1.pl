#!C:\Strawberry\perl\bin\perl.exe

# program:  bif712assignment1.pl
# assignment: assignment 1
# author:   winfield ly
# student id: 014587158
# instructor: danny abestris
# due date: october 16, 2015
# section: BIF712A
# purpose:  to write a Perl program to filter out the correct base pairs
#           in a DNA sequence, output the sequence as amino acids and the 
#           total molecular weight of the sequence

# Oath:

# Student Assignment Submission Form
# ==================================
# I declare that the attached assignment is wholly my own work
# in accordance with Seneca Academic Policy.  No part of this
# assignment has been copied manually or electronically from any
# other source (including web sites) or distributed to other students.

# Name(s)                                          Student ID(s)
# Winfield Ly                                      014587158

use strict;
use warnings;

# Created hash table to match the key (mRNA codon) to the value (amino acid letters)
my %amino_acids = (AAA=>'K', AAG=>'K', GAA=>'E', GAG=>'E',
                   AAC=>'N', AAU=>'N', GAC=>'D', GAU=>'D',
                   ACA=>'T', ACC=>'T', ACG=>'T', ACU=>'T',
                   GCA=>'A', GCC=>'A', GCG=>'A', GCU=>'A',
                   GGA=>'G', GGC=>'G', GGG=>'G', GGU=>'G',
                   GUA=>'V', GUC=>'V', GUG=>'V', GUU=>'V',
                   AUA=>'M', AUG=>'M', UAA=>'*', UAG=>'*',
                   UGA=>'*', AUC=>'I', AUU=>'I', UAC=>'Y',
                   UAU=>'Y', CAA=>'Q', CAG=>'Q', AGC=>'S',
                   AGU=>'S', UCA=>'S', UCC=>'S', UCG=>'S',
                   UCU=>'S', CAC=>'H', CAU=>'H', UGC=>'C',
                   UGU=>'C', CCA=>'P', CCC=>'P', CCG=>'P',
                   CCU=>'P', UGG=>'W', AGA=>'R', AGG=>'R',
                   CGA=>'R', CGC=>'R', CGG=>'R', CGU=>'R',
                   UUA=>'L', UUG=>'L', CUA=>'L', CUC=>'L',
                   CUG=>'L', CUU=>'L', UUC=>'F', UUU=>'F');

# Created hash table to match the key (nucleotides) to the value (molecular weight)
my %molecular_weight = (A=>'135.13', T=>'126.10', C=>'111.10', G=>'150.12',
                        U=>'112.10');

# Declared variables                        
my $sequence_input = $ARGV[0];
my ($i, $j, $k, $e, $l, $y, $t, $DNA_seq, $DNA1, $DNA2, $DNA3, $RNA1, $RNA2, $DNA_afterseq, $molecular_g_mol, $aa_seq, $aa_group, $aa_group2, $aa_group3, $aa_group4, $spaces, $space_removed);
print "Please enter a DNA sequence for analysis: ";
chomp($sequence_input = <STDIN>);
# print "$sequence_input";

# Change the sequence from lower case to upper case
$sequence_input = uc ($sequence_input);
$DNA_seq = $sequence_input;
# print "$sequence_input";

# Read the DNA sequence $DNA_seq, ignore the junk DNA by searching the DNA bases (ATCG) one character
# at a time in $DNA_seq. When it encounters the A, T, C, or G, it stores the character in the variable
# $DNA_afterseq. Then it concatenates to the end of another variable $DNA1 
$i = 0;
while ($i < length($DNA_seq)) {
	$DNA_afterseq = substr($DNA_seq, $i, 1);
   if ($DNA_afterseq eq 'A' || $DNA_afterseq eq 'T' || $DNA_afterseq eq 'C' || $DNA_afterseq eq 'G') {
      $DNA1 = $DNA1 . $DNA_afterseq;
      $i++;
	}
   else {
      $i++;
   }
}

# Read the DNA sequence $DNA1 one base at a time, and store it in the string $DNA2. It is then used
# as a key to read in the hash table with the appropriate molecular weight corresponding to the letter
# is currently stored in the variable $DNA2 . The value is retrieved and stored in $DNA3, and then added
# to get the total molecular weight of the sequence.
$l = 0;
$molecular_g_mol = 0;
while ($l < length($DNA1)) {
   $DNA2 = substr($DNA1, $l, 1);
   $DNA3 = $molecular_weight{$DNA2};
   $molecular_g_mol = $molecular_g_mol + $DNA3;
   $l++;
}

# Converts DNA sequence to mRNA bases using transliteration function
$DNA1 =~ tr/TCGA/AGCU/;
# print "$DNA1";

# Search the variable $DNA1 3 bases at a time. When it finds 3 bases, stores 
# into the variable $RNA1 then looks up the hash table with the appropriate key
# to retrieve the value to store in the variable $RNA2. Concatenate the string in $RNA2
# into $aa_seq. At the end of the mRNA sequence, if there aren't enough bases (3) to retrieve
# the amino acid, ignore them.
$j = 0;
while ($j <= length($DNA1) - 3) {
   $RNA1 = substr($DNA1, $j, 3);
   $RNA2 = $amino_acids{$RNA1};
   $aa_seq = $aa_seq . $RNA2;
   $j = $j + 3;
}

# Search in $aa_seq for every 10 bases at a time and store in $aa_group
# and concatenate each part of the sequence into $aa_group2 plus a space at the end
$y = 0;
while ($y <= length($aa_seq)) {
   $aa_group = substr($aa_seq, $y, 10);
   $aa_group2 = $aa_group2 . $aa_group;
   $aa_group2 = $aa_group2 . ' ';

   $y += 10;
}

# At the end of each row after 6 groups has been output,
# a new line is entered to go to the new row
$t = 65;
while ($t <= length($aa_group2)) {
   $spaces = substr($aa_group2, $t, 1, "\n");
   
   $t += 66;
}

#Remove the space in the last row
$space_removed = chop($aa_group2);

# The numbers relating to the first character of each row
# is shown with 10 spaces from the left side of the screen 
# before the start of the amino acid sequence.
$k = 0;
$e = 1;
while ($k < length($aa_group2)) {
   printf("%10d ", $e);
   $aa_group4 = substr($aa_group2, $k, 66);
   print "$aa_group4";
   $k += 66;
   $e += 60;
} 

#Print the molecular weight of the DNA sequence to 4 decimal places
printf ("\n%.4f", $molecular_g_mol);