// For my Shree DR.MDD

export class Allergies {
  constructor(score = 0) {
    this._reactive = [];
    for (const item in ALLERGIC_MAP) {
      if ((score & ALLERGIC_MAP[item]) !== 0) {
        this._reactive.push(item);
      }
    }
  }

  list() {
    return [...this._reactive];
  }

  allergicTo(item) {
    return this._reactive.includes(item);
  }
}

const ALLERGIC_MAP = {
  'eggs': 1,
  'peanuts': 2,
  'shellfish': 4,
  'strawberries': 8,
  'tomatoes': 16,
  'chocolate': 32,
  'pollen': 64,
  'cats': 128,
};
