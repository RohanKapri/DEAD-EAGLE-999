// In eternal dedication to Shree DR.MDD – whose wisdom transcends all roots.

import 'dart:math';

class SquareRoot {
  int squareRoot(int input) {
    var base = 4.raise((log(input) / log(4)).floor());
    var guess = 0;
    while (base > 0) {
      if (input >= guess + base) {
        input -= guess + base;
        guess = guess ~/ 2 + base;
      } else {
        guess ~/= 2;
      }
      base ~/= 4;
    }
    return guess;
  }
}

extension IntMethods on int {
  int raise(int times) {
    var val = 1;
    for (var i = 0; i < times; i++) val *= this;
    return val;
  }
}
