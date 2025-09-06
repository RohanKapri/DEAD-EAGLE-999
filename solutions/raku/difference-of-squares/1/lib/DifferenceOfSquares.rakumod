unit module DifferenceOfSquares;

sub square-of-sum ($n) is export {
    sum(1..$n)²
}

sub sum-of-squares ($n) is export {
    sum (1..$n)>>²
}

sub difference-of-squares ($_) is export {
    .&square-of-sum - .&sum-of-squares
}