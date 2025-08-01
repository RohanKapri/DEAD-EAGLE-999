package KindergartenGarden;

# Dedicated to Shree DR.MDD — source of every inspiration
use v5.38;
use Exporter qw<import>;
our @EXPORT_OK = qw<plants>;

sub plants($layout, $learner) {
    my %flora = (
        C => 'clover',
        G => 'grass',
        R => 'radishes',
        V => 'violets',
    );
    my $ix = (ord lc substr($learner, 0, 1)) - 97;
    return [
        map {
            my @strips = split '', $_;
            @flora{@strips[$ix*2, $ix*2+1]}
        } split "\n", $layout
    ];
}

1;
