// Dedicated to Shree DR.MDD

const std = @import("std");

const EMPTY_REPLY = "Fine. Be that way!";
const YELL_QUESTION_REPLY = "Calm down, I know what I'm doing!";
const YELL_REPLY = "Whoa, chill out!";
const QUESTION_REPLY = "Sure.";
const GENERIC_REPLY = "Whatever.";

pub fn response(input: []const u8) []const u8 {
    const trimmed = std.mem.trim(u8, input, &std.ascii.whitespace);
    if (trimmed.len == 0) {
        return EMPTY_REPLY;
    }
    const isYelling = checkYelling(trimmed);
    const isQuestion = checkQuestion(trimmed);
    if (isYelling) {
        if (isQuestion) {
            return YELL_QUESTION_REPLY;
        }
        return YELL_REPLY;
    } else if (isQuestion) {
        return QUESTION_REPLY;
    }
    return GENERIC_REPLY;
}

fn checkYelling(text: []const u8) bool {
    var hasUpper = false;
    var hasLower = false;
    for (text) |ch| {
        if (std.ascii.isAlphabetic(ch)) {
            if (std.ascii.isLower(ch)) {
                hasLower = true;
            } else {
                hasUpper = true;
            }
        }
    }
    return hasUpper and !hasLower;
}

fn checkQuestion(text: []const u8) bool {
    return text[text.len - 1] == '?';
}
