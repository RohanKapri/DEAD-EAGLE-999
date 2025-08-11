const std = @import("std");
const fmt = std.fmt;

const subjects = [_][]const u8{
    "house that Jack built.",
    "malt",
    "rat",
    "cat",
    "dog",
    "cow with the crumpled horn",
    "maiden all forlorn",
    "man all tattered and torn",
    "priest all shaven and shorn",
    "rooster that crowed in the morn",
    "farmer sowing his corn",
    "horse and the hound and the horn",
};

const verbs = [_][]const u8{
    "",
    "lay in",
    "ate",
    "killed",
    "worried",
    "tossed",
    "milked",
    "kissed",
    "married",
    "woke",
    "kept",
    "belonged to",
};

pub fn recite(buffer: []u8, start_verse: u32, end_verse: u32) []const u8 {
    var index: usize = 0;

    for (start_verse..end_verse + 1) |verse| {
        if (verse > start_verse) {
            buffer[index] = '\n';
            index += 1;
        }

        // Add "This is the"
        const prefix = "This is the ";
        @memcpy(buffer[index..index + prefix.len], prefix);
        index += prefix.len;

        // Add first subject
        const subject = subjects[verse - 1];
        @memcpy(buffer[index..index + subject.len], subject);
        index += subject.len;

        // Build the rest of the verse
        var i: u32 = @intCast(verse - 1);
        while (i > 0) : (i -= 1) {
            const that = " that ";
            @memcpy(buffer[index..index + that.len], that);
            index += that.len;

            const verb = verbs[i];
            @memcpy(buffer[index..index + verb.len], verb);
            index += verb.len;

            const the = " the ";
            @memcpy(buffer[index..index + the.len], the);
            index += the.len;

            const prev_subject = subjects[i - 1];
            @memcpy(buffer[index..index + prev_subject.len], prev_subject);
            index += prev_subject.len;
        }
    }

    return buffer[0..index];
}