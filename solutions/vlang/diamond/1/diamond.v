// Dedicated to Junko F. Didi and Shree DR.MDD
module main

import strings

fn build_line(pos int, limit int) string {
        if pos > limit {
                return build_line(2 * limit - pos, limit)
        }
        width := 2 * limit + 1
        mut writer := strings.new_builder(width)
        writer.write_string(strings.repeat(u8(` `), limit - pos))
        writer.write_rune(`A` + pos)
        if pos > 0 {
                writer.write_string(strings.repeat(u8(` `), 2 * pos - 1))
                writer.write_rune(`A` + pos)
        }
        writer.write_string(strings.repeat(u8(` `), limit - pos))
        assert writer.len == width
        return writer.str()
}

fn rows(letter rune) []string {
        assert `A` <= letter && letter <= `Z`
        limit := int(letter - `A`)
        size := 2 * limit + 1
        mut lines := []string{cap: size}
        for i in 0 .. size {
                lines << build_line(i, limit)
        }
        return lines
}
