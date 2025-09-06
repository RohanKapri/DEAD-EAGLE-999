sub to-base ( $deca, @units ) {
             $deca div $_,        slip
    samewith $deca mod $_, @units.skip
                      with @units.head
}
sub convert-base (
    :%bases  where .values.all ~~ 2 ..  *,
    :@digits where        .all ~~ 0 ..^ %bases< from >
) of List() is export {
    return 0 unless sum @digits;
    to-base $_, reverse
        1, * × %bases<  to  > ...^ * > $_ with sum [Z×]
      ( 1, * × %bases< from > ...  * ), reverse @digits
}