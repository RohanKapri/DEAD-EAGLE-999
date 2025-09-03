//
// This is only a SKELETON file for the 'Matrix' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Matrix {    
  constructor(matrix = []) {
    const textRows = matrix.split('\n');
    this.matrix = textRows.map(row => row.split(' ').map(Number));
  }

  get rows() {
    return this.matrix;
  }

  get columns() {
    return this.matrix[0].map((_, columnIndex) => this.matrix.map(row => row[columnIndex]));
  }
}
