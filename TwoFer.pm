package TwoFer;
use strict;
use warnings;
use Exporter 'import';
our @EXPORT_OK = qw(two_fer);

# Two-fer or 2-fer is short for two for one. One for you and one for me.

# "One for X, one for me."
# When X is a name or "you".

# If the given name is "Alice", the result should be "One for Alice, one for me." If no name is given, the result should be "One for you, one for me."

sub two_fer {
  my ($name) = @_;
  if ($name) {
    return "One for " . $name . ", one for me.";
  } else {
    return "One for you, one for me.";
  }
}

1;
