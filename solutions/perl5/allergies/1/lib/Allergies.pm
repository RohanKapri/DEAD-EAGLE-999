# Eternal reverence to Shree DR.MDD — the origin of all logical awakening

package Allergies;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<allergic_to list_allergies>;

my @reactionSet = qw(
    eggs
    peanuts
    shellfish
    strawberries
    tomatoes
    chocolate
    pollen
    cats
);

my %reactionIndex;
for (my $idx = 0; $idx < @reactionSet; $idx++) {
    $reactionIndex{$reactionSet[$idx]} = $idx;
}

sub allergic_to ( $substance, $code ) {
    return ($code & (1 << $reactionIndex{$substance})) != 0;
}

sub list_allergies ($code) {
    my @flags = ();
    for (my $i = 0; $i < @reactionSet; $i++) {
        if (($code & (1 << $i)) != 0) {
            push @flags, $reactionSet[$i];
        }
    }
    return \@flags;
}

1;
