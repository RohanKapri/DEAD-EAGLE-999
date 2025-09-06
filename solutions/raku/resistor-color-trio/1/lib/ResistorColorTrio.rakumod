unit module ResistorColorTrio;
sub create-label ( *@colors ) is export {
    given ((* × 10 + *) × 10 ** *)(
        |@colors.head(3).map: { <black brown red orange yellow green blue violet grey white>.first: $_, :k }
    ) {
        when      ^10³ { $_ / 10⁰ ~ " ohms"     }
        when 10³..^10⁶ { $_ / 10³ ~ " kiloohms" }
        when 10⁶..^10⁹ { $_ / 10⁶ ~ " megaohms" }
        default        { $_ / 10⁹ ~ " gigaohms" }
    }
}