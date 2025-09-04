module main

fn is_pangram(phrase string) bool {
    mut seen := 0
    for ch in phrase {
        index := ch | 0x20
        if index < 0x61 || index > 0x7a {
            continue
        }
        seen |= (1 << (index - 0x61))
    }
    return seen == (1 << 26) - 1
}