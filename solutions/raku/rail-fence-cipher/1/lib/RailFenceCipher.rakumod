sub zigzag($rails, @a) {
    @a[sort(((0...$rails-1...1) <<,>> @a.keys), :k)]
}
sub zigzag-encode($plain-text, $rails) is export {
    zigzag($rails, $plain-text.comb).join
}
sub zigzag-decode($cipher-text, $rails) is export {
    $cipher-text.comb[zigzag($rails, ^$cipher-text.chars).sort(:k)].join
}