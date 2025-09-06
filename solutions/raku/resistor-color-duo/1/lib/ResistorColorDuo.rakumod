unit module ResistorColorDuo;

sub decoded-value ( *@colors ) is export {
    @colors
        .head(2)
        .map({ <black brown red orange yellow green blue violet grey white>.first: $_, :k })
        .reduce: * × 10 + *
}