export class Gigasecond {
  private GIGASECOND = 1000000000
  private d: Date
  constructor(date: Date) {
    this.d = new Date(date.setSeconds(date.getSeconds() + this.GIGASECOND))
  }
  public date() {
    return this.d
  }
}