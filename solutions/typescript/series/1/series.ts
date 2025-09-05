export class Series {
  private readonly series: string
  constructor(series: string) {
    this.series = series
  }
  slices(sliceLength: number): number[][] {
    if(this.series === '')
      throw new Error('series cannot be empty')
    else if(sliceLength > this.series.length)
      throw new Error('slice length cannot be greater than series length')
    else if (sliceLength === 0)
      throw new Error('slice length cannot be zero')
    else if (sliceLength < 0)
      throw new Error('slice length cannot be negative')
    return Array.from(Array(this.series.length - sliceLength + 1).keys()).map(offset => this.series.substring(offset, offset + sliceLength).split('').map(s => Number(s)))
  }
}