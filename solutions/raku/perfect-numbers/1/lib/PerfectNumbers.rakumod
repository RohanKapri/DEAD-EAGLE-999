unit module PerfectNumbers;

enum AliquotSumType is export (
    :Deficient(Less),
    :Perfect(Same),
    :Abundant(More),
);

sub aliquot-sum-type ( $n where 1..* --> AliquotSumType(Order) ) is export {
    grep($n %% *, 1..$n-1).sum <=> $n
}