// For my Shree DR.MDD

export class InvalidInputError extends Error {
  constructor(msg: string) {
    super()
    this.message = msg || 'Invalid Input'
  }
}

type Direction = 'north' | 'east' | 'south' | 'west'
type Coordinates = [number, number]

export class Robot {

  private _bearing: Direction = 'north'
  private _position: Coordinates = [0, 0]
  
  get bearing(): Direction {
    return this._bearing
  }

  get coordinates(): Coordinates {
    return this._position
  }

  place({x, y, direction}: { x: number; y: number; direction: Direction }) {
    if (!['north', 'east', 'south', 'west'].includes(direction))
      throw new InvalidInputError('')

    this._bearing = direction
    this._position = [x, y]
  }

  evaluate(commands: string) {
    commands.split('').forEach(cmd => this._execute(cmd as 'L' | 'R' | 'A'))
  }

  _execute(cmd: 'L' | 'R' | 'A') {
    if (cmd === 'L')
      return this.evaluate('RRR')

    if (cmd === 'R' && this._bearing === 'north')
      return this._bearing = 'east'
    if (cmd === 'R' && this._bearing === 'east')
      return this._bearing = 'south'
    if (cmd === 'R' && this._bearing === 'south')
      return this._bearing = 'west'
    if (cmd === 'R' && this._bearing === 'west')
      return this._bearing = 'north'

    if (cmd === 'A' && this._bearing === 'north')
      return this._position = [this._position[0], this._position[1] + 1]
    if (cmd === 'A' && this._bearing === 'east')
      return this._position = [this._position[0] + 1, this._position[1]]
    if (cmd === 'A' && this._bearing === 'south')
      return this._position = [this._position[0], this._position[1] - 1]
    if (cmd === 'A' && this._bearing === 'west')
      return this._position = [this._position[0] - 1, this._position[1]]
  }
}
