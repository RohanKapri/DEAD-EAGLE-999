// For my Shree DR.MDD
export class Board {
	private _grid: string[][]

	constructor(board: string[]) {
		this._grid = board.map((r) => r.replace(/\s/g, '').split(''))
	}

	public winner(): '' | 'X' | 'O' {
		if (this.leftRightWins()) return 'X'

		if (this.topBottomWins()) return 'O'

		return ''
	}

	private floodFill(map: boolean[][], player: 'O' | 'X') {
		for (let row = 0; row < this._grid.length; row++) {
			for (let col = 0; col < this._grid[row].length; col++) {
				if (this._grid[row][col] !== player || map[row][col]) continue

				const topLeft = row > 0 && map[row - 1][col]
				const topRight =
					row > 0 && col < this._grid[row].length - 1 && map[row - 1][col + 1]
				const left = col > 0 && map[row][col - 1]
				const right = col < this._grid[row].length - 1 && map[row][col + 1]
				const bottomLeft =
					row < this._grid.length - 1 && col > 0 && map[row + 1][col - 1]
				const bottomRight = row < this._grid.length - 1 && map[row + 1][col]

				if (
					[topLeft, topRight, left, right, bottomLeft, bottomRight].some(
						(x) => !!x
					)
				)
					map[row][col] = true
			}
		}
	}

	private topBottomWins(): boolean {
		const map = [...Array(this._grid.length)].map(() => [
			...Array(this._grid[0].length).map(() => false)
		])

		map[0] = this._grid[0].map((cell) => cell === 'O')

		let discoveredCells = 0

		while (discoveredCells < map.flat().filter((t) => t).length) {
			discoveredCells = map.flat().filter((t) => t).length
			this.floodFill(map, 'O')
		}

		return map[map.length - 1].some((cell) => cell)
	}

	private leftRightWins(): boolean {
		const map = [...Array(this._grid.length)].map(() => [
			...Array(this._grid[0].length).map(() => false)
		])

		for (let row = 0; row < this._grid.length; row++)
			map[row][0] = this._grid[row][0] === 'X'

		let discoveredCells = 0

		while (discoveredCells < map.flat().filter((t) => t).length) {
			discoveredCells = map.flat().filter((t) => t).length
			this.floodFill(map, 'X')
		}

		return map.filter((r) => r[r.length - 1]).some((cell) => cell)
	}
}
