# Declare package 'Grains' with version
package Grains 1;
use strict;
use warnings;
use bigint;

# Calculate the number of grains of wheat on a chessboard given that the number on each square doubles.
# There once was a wise servant who saved the life of a prince. The king promised to pay whatever the servant could dream up. Knowing that the king loved chess, the servant told the king he would like to have grains of wheat. One grain on the first square of a chess board. Two grains on the next. Four on the third, and so on.
# There are 64 squares on a chessboard.

# Write code that shows:
# how many grains were on each square, and
# the total number of grains


sub square {
  my ($number) = @_;
  my $rice = 2 ** ($number - 1);
  return $rice;
  
}

sub total {
  my ($total, $rice);
  my $grain = 0;
  for (my $i = 0; $i < 64; $i++) {
    $rice = 2 ** $grain;
    $total += $rice;
    $grain++;
  }
  return $total;
  
}

1;
