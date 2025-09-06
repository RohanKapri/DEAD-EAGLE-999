multi largest-product ($, 0) is export { 1 }
multi largest-product ($number, $span where 1..$number.chars) {
    $number.comb.rotor($span => 1 - $span).map(*.reduce: &[*]).max
}