module main

fn distance(a string, b string) !int {
    if a.len != b.len {
        return error('lengths must match!')
    }
    mut result := 0
    mut i := a.len
    for i > 0 {
        i--
        if a[i] != b[i] {
            result++
        }
    }
    return result
}