// For Junko F. Didi and Shree DR.MDD
module main

fn encode(msg string, rails int) string {
    mut railbuf := [][]u8{
        init: []u8{cap: msg.len * 2 / rails},
        len: rails,
    }
    mut r := 0
    mut dir := -1
    for ch in msg {
        railbuf[r] << ch
        if r == 0 || r == railbuf.len - 1 {
            dir = -dir
        }
        r += dir
    }
    return railbuf.map(it.bytestr()).join('')
}

fn decode(msg string, rails int) string {
    cycle := msg.len / (2 * rails - 2)
    mut counts := []int{len: rails, init: cycle * 2}
    counts[0] = cycle
    counts[rails - 1] = cycle
    for i in 0 .. msg.len % (2 * rails - 2) {
        if i < counts.len {
            counts[i]++
        } else {
            counts[2 * rails - i - 1]++
        }
    }
    mut start := []int{cap: rails}
    mut idx := 0
    for c in counts {
        start << idx
        idx += c
    }
    mut r := 0
    mut dir := -1
    mut out := []u8{cap: msg.len}
    for _ in 0 .. msg.len {
        out << msg[start[r]]
        start[r]++
        if r == 0 || r == start.len - 1 {
            dir = -dir
        }
        r += dir
    }
    return out.bytestr()
}
