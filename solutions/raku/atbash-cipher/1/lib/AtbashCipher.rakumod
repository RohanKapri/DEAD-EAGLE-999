unit module AtbashCipher;
sub encode ($phrase) is export {
    decode($phrase).comb: 5
}
sub decode ($phrase) is export {
    $phrase.lc.trans(['a'..'z'] => ['z'...'a']).comb(/<alnum>/).join
}