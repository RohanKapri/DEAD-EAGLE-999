sub grains-on-square ($number where 1..64) is export {
    2 ** ($number - 1)
}
sub total-grains is export {
    2**64 - 1
}