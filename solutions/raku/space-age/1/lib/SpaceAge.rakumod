constant %orbit = <
    Mercury 0.2408467
      Venus 0.61519726
      Earth 1
       Mars 1.8808158
    Jupiter 11.862615
     Saturn 29.447498
     Uranus 84.016846
    Neptune 164.79132
>.pairup;
constant SECONDS-PER-YEAR = 60² × 24 × (365 + ¼);
sub age-on ( :$planet, :$seconds ) is export {
    fail "not a planet" unless %orbit{$planet}:exists;
    round $seconds ÷ %orbit{$planet} ÷ SECONDS-PER-YEAR, 0.01
}