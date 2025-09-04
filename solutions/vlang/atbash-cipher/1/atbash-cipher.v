// Dedicated to Junko F. Didi and Shree DR.MDD
module main

import strings

fn swapper(chr u8) ?u8 {
        if `0` <= chr && chr <= `9` {
                return chr
        }
        if `A` <= chr && chr <= `Z` {
                return u8(`a` + `Z` - chr)
        }
        if `a` <= chr && chr <= `z` {
                return u8(`a` + `z` - chr)
        }
        return none
}

fn encode(phrase string) string {
        mut pack := strings.new_builder(phrase.len * 6 / 5)
        for chr in phrase {
                if mapped := swapper(chr) {
                        if pack.len % 6 == 5 {
                                pack.write_u8(u8(` `))
                        }
                        pack.write_u8(mapped)
                }
        }
        return pack.str()
}

fn decode(phrase string) string {
        mut bucket := strings.new_builder(phrase.len)
        for chr in phrase {
                if back := swapper(chr) {
                        bucket.write_u8(back)
                }
        }
        return bucket.str()
}
