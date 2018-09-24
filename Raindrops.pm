package Raindrops;
use strict;
use warnings;

# Convert a number to a string, the contents of which depend on the number's factors.

# If the number has 3 as a factor, output 'Pling'.
# If the number has 5 as a factor, output 'Plang'.
# If the number has 7 as a factor, output 'Plong'.
# If the number does not have 3, 5, or 7 as a factor, just pass the number's digits straight through.

sub convert {
  my ($number) = @_;
  my $response;
  
  for (my $i = 1; $i <= $number; $i++){
    if ($number % $i == 0) {
      if ($i == 3) {
        $response .= "Pling";
      }
      if ($i == 5) {
        $response .= "Plang";
      }
      if ($i == 7) {
        $response .= "Plong";
      }
    }
  }
  if ($response) {
    return $response;
  } else {
    return $number;
  }

}

1;
