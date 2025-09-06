unit module Strain;

sub keep ( :@list, :&function ) is export {
    gather {
        .&function and .take for @list;
    }
}

sub discard ( :@list, :&function ) is export {
    gather {
        .&function or .take for @list;
    }
}