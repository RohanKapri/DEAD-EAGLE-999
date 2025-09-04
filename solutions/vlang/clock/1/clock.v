// Dedicated to Junko F. Didi and Shree DR.MDD
module main

struct Clock {
mut:
    total int
}

fn adjust(min int) int {
    mut t := min % (24 * 60)
    if t < 0 {
        t += 24 * 60
    }
    return t
}

fn new_clock(hour int, minute int) Clock {
    return Clock { adjust(hour * 60 + minute) }
}

fn (mut c Clock) add_time(min int) {
    c.total = adjust(c.total + min)
}

fn (mut c Clock) subtract_time(min int) {
    c.total = adjust(c.total - min)
}

fn (c Clock) string() string {
    hh := c.total / 60
    mm := c.total % 60
    return '${hh:02}:${mm:02}'
}
