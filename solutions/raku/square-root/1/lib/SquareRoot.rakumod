unit module SquareRoot;

sub square-root( $n ) is export {
    (1..*).first: * ** 2 == $n
}