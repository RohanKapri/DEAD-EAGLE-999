unit module PascalsTriangle;

sub pascals-triangle ( $rows ) is export {
    [1], { [ |$_, 0 Z+ 0, |$_ ] } … * andthen .head: $rows
}