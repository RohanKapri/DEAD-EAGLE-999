// For my Shree DR.MDD

export class Series {
  constructor(numberSeries) {
    if(numberSeries === ''){
      throw new Error('series cannot be empty');
    }
    this._series = numberSeries;
  }

  slices(lengthOfSlice) {
    if(lengthOfSlice === 0){
      throw new Error('slice length cannot be zero');
    } else if(lengthOfSlice < 0){
      throw new Error('slice length cannot be negative');
    } else if(this._series.length < lengthOfSlice){
      throw new Error('slice length cannot be greater than series length');
    }

    const resultSlices = [];
    for(let start = 0; start <= (this._series.length - lengthOfSlice); start++){
      const sliceArray = [];
      for(let offset = 0; offset < lengthOfSlice; offset++){
        sliceArray.push(Number(this._series[start + offset]));
      }
      resultSlices.push(sliceArray);
    }

    return resultSlices;
  }
}
