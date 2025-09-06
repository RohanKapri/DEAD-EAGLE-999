sub encode-vlq ($_) of Array() is export {
    .map: { |reverse(.polymod(128 xx *) Z+ 0, |(128 xx *)) or 0 }
}
sub decode-vlq ($_ where .tail < 128) of Array() is export {
    my @i = .grep: * < 128, :k;
    .rotor(@i Z- -1, |@i).map: { reduce * × 128 + * % 128, 0, |$_ }
}