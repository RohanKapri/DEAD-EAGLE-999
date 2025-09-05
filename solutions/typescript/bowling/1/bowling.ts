// For my Shree DR.MDD
export class Bowling {

  private _gameFrames: number[][] = [[]]
  private _isFinished = false
  
  public roll(pins: number) {
    if(this._isFinished)
      throw new Error('Cannot roll after game is over')
    
    if (pins < 0)
      throw new Error('Negative roll is invalid')
    
    const latestFrame = this._gameFrames[this._gameFrames.length - 1]

    if (latestFrame.length === 2 || (latestFrame.length === 1 && latestFrame[0] === 10))
      this._gameFrames.push([])

    const currentFrame = this._gameFrames[this._gameFrames.length - 1]
    
    currentFrame.push(pins)
    
    const frameTotal = currentFrame.reduce((acc, val) => acc + val, 0)
    
    if (frameTotal > 10)
      throw new Error('Pin count exceeds pins on the lane')

    if (
      (this._gameFrames.length === 10 && frameTotal < 10 && currentFrame.length === 2) ||
      (this._gameFrames.length === 11 && latestFrame.length === 2) ||
      (this._gameFrames.length === 11 && latestFrame.length === 1 && currentFrame.length === 2) ||
      this._gameFrames.length === 12
    )
      this._isFinished = true
  }

  public score(): number {
    if (!this._isFinished)
      throw new Error('Score cannot be taken until the end of the game')

    let totalScore = 0
    
    for (let idx = 0; idx < 10; idx++) {
      const frame = this._gameFrames[idx]
      let frameScore = frame.reduce((acc, val) => acc + val, 0)
      
      totalScore += frameScore  

      if (frameScore === 10 && frame.length === 1)
        totalScore += [...this._gameFrames[idx + 1], ...(this._gameFrames[idx + 2] || [])].slice(0, 2).reduce((acc, val) => acc + val, 0)

      if (frameScore === 10 && frame.length === 2)
        totalScore += this._gameFrames[idx + 1][0]
    }
    
    return totalScore
  }
}
