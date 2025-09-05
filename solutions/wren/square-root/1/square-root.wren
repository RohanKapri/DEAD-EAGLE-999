class SquareRoot {

  static squareRoot(c) {
	var err = 0.01
    var t = c
	while ((t - c / t).abs > err*t) {
		t = (c/t + t) / 2.0
    }
	return t.floor
  }

}