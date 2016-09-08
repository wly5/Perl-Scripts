#!/home/bif712_153a14/software/bin/perl

# program:  bif712assignment2.pl
# assignment: assignment 2
# author:   winfield ly
# student id: 014587158
# instructor: danny abestris
# due date: november 27, 2015
# section: BIF712A
# purpose:  to write a Perl program to retrieve a specific GenBank file from the NCBI website
#           and to send the information back as an HTML page that displays the requested information
#           of the Genbank record for a specific organism

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
use LWP::Simple;
use Shell;
use CGI;
use CGI::Carp "fatalsToBrowser";

# NOTE: if LWP::Simple module is NOT available within your Perl distribution,
#       install with:
#       perl -MCPAN -e "install LWP::Simple"

# Declares all of the variables and arrays used in this program
my ($page, $shell, $okToPrint, $stopPrint, $attribute, $emailAttachment, $cgi, $check, $tryPrint, $attachment, @portionToDisplay, @virusNames, @lines, @genBankData, $allAttribute, $url, $virus, $fileName, $email, $portionToDisplay, $origin, $adenine, $cytosine, $thymine, $guanine);

# Prototype/Forward declare the email subroutine
sub emailProcess();

# Process and retrieve all of the form elements from the HTML form
$cgi = new CGI;
@genBankData = $cgi -> param('attributes');
$allAttribute = $cgi -> param('CHECKALL');
$virus = $cgi -> param('viruses');
$email = $cgi -> param('mailto');

# Create shell to be used for emailing
$shell = Shell->new;

# Create and open email attachment file
$emailAttachment = "Genbank.dat";
open (attachment, "> $emailAttachment") or die("Error opening attached file: $emailAttachment\n");

# Concatenate the value from the parameter 'viruses' in the HTML form to the end of the URL
$url = "ftp://ftp.ncbi.nih.gov/genomes/Viruses/";
$url .= $virus;

# Then take only the filename, which is the second portion of the string received from the parameter 'viruses' in the HTML form, to store in the variable, fileName
@virusNames = split("/", $virus);
$fileName = $virusNames[1];

# If the Genbank file isn't found, retrieve the file from NCBI
if(!(-f "$fileName")) {
   $page = get("ftp://ftp.ncbi.nih.gov/genomes/Viruses/$virus");
   die "Error retrieving GenBank file from NCBI..." unless defined($page);
   open(FD, "> $fileName") || die("Error opening file... $!\n");
   print FD "$page";
   close(FD);
}
else {
   $/ = undef;   # default record separator is undefined
   open(FD, "< $fileName") || die("Error opening file: '$fileName'\n $!\n");
   $page = <FD>; # file slurp (reads the entire file into a scalar)
   close(FD);
   $/ = "\n";    # resets the default record back to newline
}

print "Content-type: text/html\n\n";
print "<html><head><title>...</title></head><body><pre>\n";

# After the emailProcess subroutine validates the e-mail, and returns with a positive value,
# it is saved into a scalar variable
my $check2 = emailProcess();

print "Successfully downloaded GenBank File...\n<br />";

# If the Check/Uncheck All checkbox is on, print the Genbank file. If the All checkbox is off,
# then the array that contains one or more of the attribute will be check in $page that contains the GenBank file
if ($allAttribute eq 'on') {
   print "$page";
   # If the GenBank file is stored in the $page variable and matches the ORIGIN
   # attribute, then it will store in a variable called $origin. Using the 
   # transliterate function, it counts the number of occurrences of "a", "c", "g", and "t"
   # to be stored in separate variables to keep track of the total amount
   $origin = $1 if($page =~ /ORIGIN(.*)/s);
   $adenine = ($origin =~ tr/a//);
   $cytosine = ($origin =~ tr/c//);
   $guanine = ($origin =~ tr/g//);
   $thymine = ($origin =~ tr/t//);
   print "BASE COUNT      $adenine A    $cytosine C     $guanine G     $thymine T\n";
   print attachment "$page";
   print attachment "BASE COUNT      $adenine A    $cytosine C     $guanine G     $thymine T\n";
   
}
else {
   foreach $attribute (@genBankData) {
      
      # For LOCUS. 
      if ($attribute eq 'LOCUS') {
         $portionToDisplay = "";
         $portionToDisplay = $1 if($page =~ /(LOCUS.*)DEFINITION/s);
         print "$portionToDisplay";
         print attachment "$portionToDisplay";
      }
      
      # For DEFINITION. 
      if ($attribute eq 'DEFINITION') {
         $portionToDisplay = "";
         $portionToDisplay = $1 if($page =~ /(DEFINITION.*)ACCESSION/s);
         print "$portionToDisplay";
         print attachment "$portionToDisplay";
      }
      
      # For ACCESSION. 
      if ($attribute eq 'ACCESSION') {
         $portionToDisplay = "";
         $portionToDisplay = $1 if($page =~ /(ACCESSION.*)VERSION/s);
         print "$portionToDisplay";
         print attachment "$portionToDisplay";
      }
      
      # For VERSION. 
      if ($attribute eq 'VERSION') {
         $portionToDisplay = "";
         $portionToDisplay = $1 if($page =~ /(VERSION.*)DBLINK/s);
         print "$portionToDisplay";
         print attachment "$portionToDisplay";
      }
      
      # For KEYWORDS. 
      if ($attribute eq 'KEYWORDS') {
         $portionToDisplay = "";
         $portionToDisplay = $1 if($page =~ /(KEYWORDS.*)SOURCE/s);
         print "$portionToDisplay";
         print attachment "$portionToDisplay";
      }
      
      
      @lines = split('\n', $page);
      $stopPrint = $okToPrint = 0;
      # For SOURCE
      if ($attribute eq 'SOURCE') {
      
         foreach(@lines) {
            $okToPrint = 1 if($_ =~ m/SOURCE/);
         
            $stopPrint = 1, $okToPrint = 1 if($_ =~ m/REFERENCE/);
            $okToPrint = 1, $stopPrint = 0 if ($_ =~ m/SOURCE/);
      
            if($okToPrint  == 1 && $stopPrint == 0) {
               print "$_\n";
               print attachment "$_\n";
            }
            last if($stopPrint == 1);
         }
      }
      
      # For ORGANISM
      if ($attribute eq 'ORGANISM') {

         foreach (@lines) {
            $tryPrint = 1 if ($_ =~ m/ORGANISM/);
            $tryPrint = 0 if ($_ =~ m/REFERENCE/);

            if ($tryPrint == 1) {
            print "$_\n";
            print attachment "$_\n";
            }
         }  
      }
      
      # For REFERENCE
      if ($attribute eq 'REFERENCE') {
         $portionToDisplay = "";
         $portionToDisplay = $1 if($page =~ /(REFERENCE.*?)COMMENT/s);
         print "$portionToDisplay";
         print attachment "$portionToDisplay";
      }

      if ($attribute eq 'AUTHORS') {
      
         foreach(@lines) {
            $okToPrint = 1 if($_ =~ m/AUTHORS/);
         
            $stopPrint = 1, $okToPrint =0 if($_ =~ m/TITLE/);
         
            $okToPrint = 1 if ($_ =~ m/AUTHORS/);
            $stopPrint = 0 if ($_ =~ m/TITLE/);
      
            if($okToPrint  == 1 && $stopPrint == 0) {
               print "$_\n";
               print attachment "$_\n";
            }
            last if($stopPrint == 1);
         }
      }
      
      # For TITLE
      if ($attribute eq 'TITLE') {
      
         foreach(@lines) {
            $okToPrint = 1 if($_ =~ m/TITLE/);
         
            $stopPrint = 1, $okToPrint = 0 if($_ =~ m/JOURNAL/);
         
            $okToPrint = 1 if ($_ =~ m/TITLE/);
            $stopPrint = 0 if ($_ =~ m/JOURNAL/);
      
            if($okToPrint == 1 && $stopPrint == 0) {
               print "$_\n";
               print attachment "$_\n";
            }
            last if($stopPrint == 1);
         }
      }
      
      # For JOURNAL
      if ($attribute eq 'JOURNAL') {

         foreach (@lines) {
            $tryPrint = 1 if ($_ =~ m/JOURNAL/);
            $tryPrint = 0 if ($_ =~ m/PUBMED|REMARK|REFERENCE|COMMENT/g);

            if ($tryPrint == 1) {
            print "$_\n";
            print attachment "$_\n";
            }
         }  
         
      }
      
      # For MEDLINE aka PUBMED
      if ($attribute eq 'MEDLINE') {
      
         foreach(@lines) {
            $okToPrint = 1 if($_ =~ m/PUBMED/);
         
            $stopPrint = 1, $okToPrint = 0 if($_ =~ m/REFERENCE/);
         
            $okToPrint = 1 if ($_ =~ m/PUBMED/);
            $stopPrint = 0 if ($_ =~ m/REFERENCE/);
      
            if($okToPrint  == 1 && $stopPrint == 0) {
               print "$_\n";
               print attachment "$_\n";
            }
            last if($stopPrint == 1);
         }
      }
      
      # For FEATURES
      if ($attribute eq 'FEATURES') {
         @portionToDisplay = "";
         @portionToDisplay = $1 if($page =~ /(FEATURES.*)ORIGIN/s);
         print "@portionToDisplay";
         print attachment "@portionToDisplay";
      }
      
      # For ORIGIN
      if ($attribute eq 'ORIGIN') {
         @portionToDisplay = "";
         @portionToDisplay = $1 if($page =~ /(ORIGIN.*)/s);
         print "@portionToDisplay";
         print attachment "@portionToDisplay";
      }
      
      # For BASE COUNT
      if ($attribute eq 'BASECOUNT') {
         # If the GenBank file is stored in the $page variable and matches the ORIGIN
         # attribute, then it will store from ORIGIN to the end of the file in a variable called $origin. Using the 
         # transliterate function, it counts the number of occurrences of "a", "c", "g", and "t"
         # to be stored in separate variables to keep track of the total amount for each
         $origin = $1 if($page =~ /ORIGIN(.*)/s);
         $adenine = ($origin =~ tr/a//);
         $cytosine = ($origin =~ tr/c//);
         $guanine = ($origin =~ tr/g//);
         $thymine = ($origin =~ tr/t//);
         print "BASE COUNT      $adenine A    $cytosine C     $guanine G     $thymine T\n";
         print attachment "BASE COUNT      $adenine A    $cytosine C     $guanine G     $thymine T\n";
      } 

   }

}

close attachment;

# If the return value from the emailProcess subroutine is 1, send email
if ($check2 == 1) {
      $shell->mail(qq[-s "Your Genbank Results" $email < Genbank.dat]);
}

# Checks the e-mail text box on the Genbank Form whether it is a valid email address.
sub emailProcess() {
   if ($email) {
      unless ($email =~ m/.*@.*\..*./) {
         print "Error. Please enter a valid e-mail address. </body></html>";
         exit;
      }
      $check = 1;
      return $check;
   }
}

print "</pre></body></html>\n";