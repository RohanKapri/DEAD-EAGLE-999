pub fn eggCount(number: usize) usize {
    var count: usize = 0;
    var n = number;

    while (n != 0) {
        count += n & 1;
        n >>= 1;
    }

    return count;
}