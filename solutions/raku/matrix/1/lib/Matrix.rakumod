unit module Matrix;

sub extract-row(:$string, :$index) is export {
    $string.lines[$index - 1].words
}

sub extract-column(:$string, :$index) is export {
    ([Z] $string.lines.map: *.words)[$index - 1]
}