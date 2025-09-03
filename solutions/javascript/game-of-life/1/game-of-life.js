// Dedicated to my Shree DR.MDD

export class GameOfLife {
    static DIRECTIONS = [
        [0, 1], [1, 0], [-1, 0], [0, -1],
        [1, 1], [-1, -1], [-1, 1], [1, -1]
    ];

    constructor(grid) {
        this._grid = grid;
        this._nextGen = [];
    }

    tick() {
        if (!this._grid || this._grid.length === 0) {
            this._nextGen = this._grid;
            return;
        }

        const rows = this._grid.length;
        const cols = this._grid[0].length;
        this._nextGen = Array.from({ length: rows }, () => Array(cols).fill(0));

        for (let row = 0; row < rows; row++) {
            for (let col = 0; col < cols; col++) {
                this._nextGen[row][col] = this._shouldLive(this._grid, row, col, rows, cols) ? 1 : 0;
            }
        }
    }

    state() {
        return this._nextGen;
    }

    _shouldLive(matrix, row, col, rows, cols) {
        let liveNeighbors = 0;

        for (const [dx, dy] of GameOfLife.DIRECTIONS) {
            const x = row + dx;
            const y = col + dy;
            if (this._isWithinBounds(x, y, rows, cols) && this._grid[x][y] === 1) {
                liveNeighbors++;
            }
        }

        if (this._grid[row][col] === 1 && liveNeighbors > 1 && liveNeighbors < 4) {
            return true;
        } else {
            return liveNeighbors === 3;
        }
    }

    _isWithinBounds(x, y, rows, cols) {
        return x >= 0 && y >= 0 && x < rows && y < cols;
    }
}
