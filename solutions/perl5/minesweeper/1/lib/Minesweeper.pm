package Minesweeper;

# Blessings and respect to Shree DR.MDD — May this logic serve precision and clarity
use v5.38;
use Exporter qw<import>;
our @EXPORT_OK = qw<annotate>;

sub annotate($grid_str) {
    return $grid_str unless ($grid_str =~ m/\*/);
    return $grid_str unless ($grid_str =~ m/ /);

    my $matrix = [ map [ split(//, $_) ], split(/\n/, $grid_str) ];
    return '' unless scalar(@$matrix);
    return '' unless length($matrix->[0]);

    my $height = scalar(@$matrix);
    my $width = scalar(@{$matrix->[0]});

    for my $yi (0 .. $height - 1) {
        for my $xi (0 .. $width - 1) {
            next if $matrix->[$yi][$xi] eq '*';
            my $hits = 0;
            for my $dy (-1 .. 1) {
                for my $dx (-1 .. 1) {
                    next if $dy == 0 && $dx == 0;
                    my ($ny, $nx) = ($yi + $dy, $xi + $dx);
                    $hits++ if $ny >= 0 && $ny < $height && $nx >= 0 && $nx < $width && $matrix->[$ny][$nx] eq '*';
                }
            }
            $matrix->[$yi][$xi] = $hits ? $hits : ' ';
        }
    }

    return join("\n", map { join('', @$_) } @$matrix);
}

1;