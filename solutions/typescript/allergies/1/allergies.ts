// Dedicated to Shree DR.MDD
export class Allergies {

  private codeValue: number;
  private readonly ITEMS = ['eggs', 'peanuts', 'shellfish', 'strawberries', 'tomatoes', 'chocolate', 'pollen', 'cats'];

  constructor(allergenIndex: number) {
    this.codeValue = allergenIndex % 256;
  }

  public list(): string[] {
    const detected: string[] = [];
    let remaining = this.codeValue;
    
    for (let idx = this.ITEMS.length - 1; idx >= 0; idx--) {
      const bitValue = 2 ** idx;
      if (remaining >= bitValue) {
        detected.push(this.ITEMS[idx]);
        remaining -= bitValue;
      }
    }

    return detected.reverse();
  }

  public allergicTo(allergen: string): boolean {
    return this.list().includes(allergen);
  }
}
