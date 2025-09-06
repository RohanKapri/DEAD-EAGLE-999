unit module Darts;

sub score-dart ( :$x, :$y ) is export {
    <10 5 1> Z* sqrt($x² + $y²) «≤« <1 5 10> andthen .first: * > 0
}