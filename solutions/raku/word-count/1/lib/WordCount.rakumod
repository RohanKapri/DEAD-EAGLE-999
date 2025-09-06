sub count-words ($sentence) is export {
    $sentence.lc.comb(/ \w [ [ \w || \' ] * \w ] ? /).Bag
}