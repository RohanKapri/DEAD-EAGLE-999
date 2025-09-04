module main

fn is_isogram(word string) bool {
    mut seen := 0
    for ch in word {
        c := ch | 0x20
        if (c >= 0x61) && (c <= 0x7a) {
            mask := 1 << (c - 0x61)
            if (seen & mask) != 0 {
                return false
            }
            seen |= mask
        }
    }
    return true
}