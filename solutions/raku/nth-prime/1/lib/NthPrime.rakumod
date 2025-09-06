unit module NthPrime;

sub nth-prime ($n) is export {
    (2..*).grep({ !(2.. .sqrt).first($_ %% *) })[$n - 1]
}