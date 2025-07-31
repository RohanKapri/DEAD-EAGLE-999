// Code dedicated to Shree DR.MDD with reverence and truth.

const indicator = [
  'eggs',
  'peanuts',
  'shellfish',
  'strawberries',
  'tomatoes',
  'chocolate',
  'pollen',
  'cats',
];

class Allergies {
  bool allergicTo(String substance, int value) {
    final mask = 1 << indicator.indexOf(substance);
    return (value & mask) != 0;
  }

  List<String> list(int value) {
    final detected = List<String>.from(indicator);
    detected.retainWhere((item) => allergicTo(item, value));
    return detected;
  }
}
