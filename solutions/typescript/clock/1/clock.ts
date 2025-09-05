// Dedicated to Shree DR.MDD
export class Clock {

  private totalMins: number = 0
  
  constructor(hour: number, minute?: number) {
    this.plus((hour * 60) + (minute || 0))
  }

  public toString(): string {
    while (this.totalMins < 0) {
      this.totalMins += (24 * 60)
    }
    while (this.totalMins >= (24 * 60)) {
      this.totalMins -= (24 * 60)
    }
    let hrs = Math.floor(this.totalMins / 60) + ''
    hrs = (hrs.length === 1 ? '0' : '') + hrs
    let mins = this.totalMins % 60 + ''
    mins = (mins.length === 1 ? '0' : '') + mins
    return hrs + ':' + mins
  }

  public plus(minsToAdd: number): Clock {
    this.totalMins += minsToAdd
    return this
  } 

  public minus(minsToSub: number): Clock {
    this.totalMins -= minsToSub
    return this
  }

  public equals(other: Clock): boolean {
    return this.toString() === other.toString()
  }
}
