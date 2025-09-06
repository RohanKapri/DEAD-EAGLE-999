constant %scores =
    <AEIOULNRST DG BCMP FHVWY K JX QZ>.map(*.comb) »=>»
    <1          2  3    4     5 8  10>; 
sub scrabble-score ($_) is export {
    .uc
    .comb
    .map({ %scores{$_} })
    .sum
}