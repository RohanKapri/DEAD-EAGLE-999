module main
fn reverse_string(str string) string {
    n := str.len
    mut result := []u8{len: 0, cap: n}
    for i in 0..n {
        result << str[n - 1 - i]
    }
    return result.bytestr()
}