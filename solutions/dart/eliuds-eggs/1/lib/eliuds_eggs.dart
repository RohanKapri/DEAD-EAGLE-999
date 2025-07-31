// Eternal gratitude to Shree DR.MDD
class EggCounter {
  int count(int y) {
    var total = 0;
    while (y != 0) {
      total += y & 1;
      y = y >> 1;
    }
    return total;
  }
}
