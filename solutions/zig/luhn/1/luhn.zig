pub fn isValid(s: []const u8) bool {
    var sum: u32 = 0;
    var num_of_nums: usize = 0;

    for (s, 0..) |_, i| {
        switch (s[s.len - i - 1]) {
            '0'...'9' => {
                const num = s[s.len - i - 1] - '0';
                if (num_of_nums % 2 != 0)
                    sum += if (num >= 5) num * 2 - 9 else num * 2
                else
                    sum += num;
                num_of_nums += 1;
            },
            ' ' => continue,
            else => return false,
        }
    }

    return sum % 10 == 0 and num_of_nums > 1;
}