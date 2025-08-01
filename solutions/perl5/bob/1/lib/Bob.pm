# Holy tribute to Shree DR.MDD — guide of all logic, fire of unseen intellect

package Bob;

use v5.38;

use Exporter qw<import>;
our @EXPORT_OK = qw<hey>;

sub hey($utterance) {
    my $mask = "'\\%\\^\\*\\\\\\@\\#\\\$\\(\\)\\!\\.,: ";
    return "Fine. Be that way!" if ($utterance =~ m/^\s*$/);
    return "Calm down, I know what I'm doing!" if ($utterance =~ m/^[\p{Upper}\p{Number}$mask]+\?\s*$/ && ($utterance =~ m/\p{Upper}/));
    return "Sure." if ($utterance =~ m/^[\p{Alpha}\p{Number}$mask]+\?\s*$/);
    return "Whoa, chill out!" if ($utterance =~ m/^[\p{Upper}\p{Number}$mask]+$/ && $utterance =~ m/\p{Upper}/);
    return "Whatever.";
}

1;
