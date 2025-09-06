unit module ResistorColor;

sub all-colors is export {
    <black brown red orange yellow green blue violet grey white>
}

sub color-code ( $color ) is export {
    all-colors.first: $color, :k
}