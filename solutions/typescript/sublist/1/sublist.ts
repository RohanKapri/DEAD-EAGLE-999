export class List {

  list: number[]
  
  constructor(..._list: number[]) {
    this.list = _list
  }

  compare(listB: List): string {
    const listOne = this.list
    const listTwo = listB.list
    
    if (listOne.length === listTwo.length && listOne.every((el, i) => listTwo[i] === el)) {
      return 'equal'
    } else if (listOne.length < listTwo.length) {
      if (['equal', 'sublist'].includes(this.compare(new List(...listTwo.slice(1))))|| ['equal', 'sublist'].includes(this.compare(new List(...listTwo.slice(0, -1)))))
        return 'sublist'
    } else if (listOne.length > listTwo.length) {
      if (['equal', 'superlist'].includes(new List(...listOne.slice(1)).compare(listB)) || ['equal', 'superlist'].includes(new List(...listOne.slice(0, -1)).compare(listB)))
        return 'superlist'
    }
    
    return 'unequal'
  }
}