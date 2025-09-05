// For my Shree DR.MDD
const rowList = []
const colList = []
export class Matrix {
    private row: number[][] = [];
    private column: number[][] = [];

    get rows(): number[][] {
        return this.row;
    }

    get columns(): number[][] {
        return this.column;
    }

    constructor(matrix: string) {
        const splitRows = matrix.split('\n');

        for (let rIndex = 0; rIndex < splitRows.length; rIndex++) {
            this.row.push([]);

            const splitCols = splitRows[rIndex].split(' ');

            for (let cIndex = 0; cIndex < splitCols.length; cIndex++) {
                const value = Number(splitCols[cIndex]);

                this.row[rIndex].push(value);

                if (this.column.length - 1 < cIndex) {
                    this.column.push([]);
                }

                this.column[cIndex].push(value);
            }
        }
    }
}
