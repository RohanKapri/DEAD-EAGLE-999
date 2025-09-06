sub is-armstrong-number ($_) is export {
    $_ == [+] .comb »**» .chars
}