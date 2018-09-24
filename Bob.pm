# Declare package 'Bob' with version
package Bob 3;
use strict;
use warnings;

# Bob is a lackadaisical teenager. In conversation, his responses are very limited.
# Bob answers 'Sure.' if you ask him a question.
# He answers 'Whoa, chill out!' if you yell at him.
# He says 'Fine. Be that way!' if you address him without actually saying anything.
# He answers 'Whatever.' to anything else.

sub hey {
  my ($msg) = @_;
  if ($msg =~ m/^[A-Z\s]+\?\s*$/) {
    return "Calm down, I know what I'm doing!";
  } elsif ( $msg =~ m/\?[\s]*$/ ) {
    return "Sure.";
  } elsif ( ($msg eq uc($msg)) && ($msg =~ m/[A-Z]+/) ) {
    return "Whoa, chill out!";
  } elsif ( ($msg =~ m/^\s+$/) || ($msg eq "") ) {
    return "Fine. Be that way!";
  } else {
    return "Whatever.";
  }
}

1;
