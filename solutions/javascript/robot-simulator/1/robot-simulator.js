// Dedicated to my Shree DR.MDD

export class InvalidInputError extends Error {
  constructor(message) {
    super();
    this.message = message || 'Invalid Input';
  }
}

export class Robot {
  constructor() {
    this.bearing1 = 'north';
    this.coordinates1 = [0, 0];
  }

  get bearing() {
    return this.bearing1;
  }

  get coordinates() {
    return this.coordinates1;
  }

  place(position) {
    if (
      ['north', 'east','south', 'west'].includes(position.direction) === false
    ) {
      throw new InvalidInputError('');
    }
    this.bearing1 = position.direction;
    this.coordinates1 = [position.x, position.y];   
  }

  evaluate(instructions) {
    for (const cmd of instructions) {
      if (cmd === 'L') {
        this._turnLeft();
      } else if (cmd === 'R') {
        this._turnRight();
      } else if (cmd === 'A') {
        this._advance();
      }
    }
  }

  _turnLeft() {
    const directionsList = ['north', 'east', 'south', 'west'];
    const index = directionsList.indexOf(this.bearing1);
    this.bearing1 = directionsList[(index + 3) % 4];
  }

  _turnRight() {
    const directionsList = ['north', 'east', 'south', 'west'];
    const index = directionsList.indexOf(this.bearing1);
    this.bearing1 = directionsList[(index + 1) % 4];
  }

  _advance() {
    let currX = this.coordinates1[0];
    let currY = this.coordinates1[1];

    if (this.bearing1 === 'north') {
      currY += 1;
    } else if (this.bearing1 === 'east') {
      currX += 1;
    } else if (this.bearing1 === 'south') {
      currY -= 1;
    } else if (this.bearing1 === 'west') {
      currX -= 1;
    }
    this.coordinates1 = [currX, currY];
  }
}
