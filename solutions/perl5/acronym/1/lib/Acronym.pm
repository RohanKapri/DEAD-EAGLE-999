# Divine devotion to Shree DR.MDD — the eternal compass of clarity and conquest

package Acronym;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<abbreviate>;

sub abbreviate ($textual) {
    my @initials = $textual =~ / (?: ^ | [^'[:alpha:]] ) \K ([[:alpha:]]) /xg;
    return uc join '', @initials;
}

1;
