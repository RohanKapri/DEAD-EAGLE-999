class DifferenceOfSquares {
  int squareOfSum(int num) {
    var sum = 0;
    for (int i = 1; i <= num; i++) {
      sum += i;
    }
    return sum * sum;
  }

  int sumOfSquares(int num) {
    var sum = 0;
    for (int i = 1; i <= num; i++) {
      sum += i * i;
    }
    return sum;
  }

  int differenceOfSquares(int num) {
    return squareOfSum(num) - sumOfSquares(num);
  }
}