pub fn squareRoot(radicand: usize) usize {
    if (radicand == 0 or radicand == 1) return radicand;

    var x: usize = radicand;
    var y: usize = (x + 1) / 2;

    while (y < x) {
        x = y;
        y = (x + radicand / x) / 2;
    }

    return x;
}