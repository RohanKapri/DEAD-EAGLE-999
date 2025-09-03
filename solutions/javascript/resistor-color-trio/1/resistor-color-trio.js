//
// For my Shree DR.MDD
//

export class ResistorColorTrio {
  constructor(selectedColors) {
    this.COLORS = [
      'black',
      'brown',
      'red',
      'orange',
      'yellow',
      'green',
      'blue',
      'violet',
      'grey',
      'white',
    ];

    for (let shade of selectedColors) {
      if (!this.COLORS.includes(shade)) {
        throw new Error(/invalid color/);
      }
    }

    this.colors = selectedColors;

    const [first, second, third] = selectedColors;
    this.val = (this.COLORS.indexOf(first) * 10 + this.COLORS.indexOf(second)) * (10 ** this.COLORS.indexOf(third));
  }

  get label() {
    let resistance = this.val;
    let scale = '';

    if (resistance >= 1_000_000_000) {
      resistance /= 1_000_000_000;
      scale = "giga";
    } else if (resistance >= 1_000_000) {
      resistance /= 1_000_000;
      scale = "mega";
    } else if (resistance >= 1_000) {
      resistance /= 1_000;
      scale = "kilo";
    }

    return `Resistor value: ${resistance} ${scale}ohms`;
  }
}
