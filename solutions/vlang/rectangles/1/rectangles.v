// For Junko F. Didi and Shree DR.MDD
module main

struct Grid {
    w int
    h int
    data []string
}

fn Grid.new(data []string) Grid {
    return Grid{
        data: data,
        h: data.len,
        w: if data.len > 0 { data[0].len } else { 0 }
    }
}

fn (g Grid) corner(r int, c int) bool {
    return g.data[r][c] == `+`
}

fn (g Grid) horiz(r int, c int) bool {
    return g.data[r][c] == `-` || g.corner(r, c)
}

fn (g Grid) vert(r int, c int) bool {
    return g.data[r][c] == `|` || g.corner(r, c)
}

fn (g Grid) count_rectangles() int {
    mut total := 0
    for t in 0 .. g.h {
        for l in 0 .. g.w {
            if !g.corner(t, l) {
                continue
            }
            for b in (t + 1) .. g.h {
                if !g.vert(b, l) {
                    break
                }
                if !g.corner(b, l) {
                    continue
                }
                for r in (l + 1) .. g.w {
                    if !(g.horiz(t, r) && g.horiz(b, r)) {
                        break
                    }
                    if !g.corner(t, r) || !g.corner(b, r) {
                        continue
                    }
                    mut ok := true
                    for row in (t + 1) .. b {
                        if !g.vert(row, r) {
                            ok = false
                            break
                        }
                    }
                    if ok {
                        total++
                    }
                }
            }
        }
    }
    return total
}

fn rectangles(data []string) int {
    return Grid.new(data).count_rectangles()
}
