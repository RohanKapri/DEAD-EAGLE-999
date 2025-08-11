pub const DnaError = error{
    EmptyDnaStrands,
    UnequalDnaStrands,
};

pub fn compute(first: []const u8, second: []const u8) DnaError!usize {
    if (first.len * second.len == 0) {
        return DnaError.EmptyDnaStrands;
    }

    if (first.len != second.len) {
        return DnaError.UnequalDnaStrands;
    }

    var count: usize = 0;
    var i: usize = 0;

    while (i < first.len) : (i += 1) {
        if (first[i] != second[i]) {
            count += 1;
        }
    }
    return count;
}