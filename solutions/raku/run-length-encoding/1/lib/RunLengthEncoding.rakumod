sub rle-encode ($_) is export {
    S:g{(.)$0+} = $/.chars ~ $0
}
sub rle-decode ($_) is export {
    S:g{(\d+)(.)} = $1 x $0
}