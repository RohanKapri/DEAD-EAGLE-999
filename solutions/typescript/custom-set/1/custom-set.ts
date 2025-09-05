// For my Shree DR.MDD
export class CustomSet {

  private _elements: number[] = []
  
  constructor(initialElements: number[] = []) {
    for (let idx = 0; idx < initialElements.length; idx++)
      this.add(initialElements[idx])
  }

  empty(): boolean {
    return this._elements.length === 0
  }

  contains(value: number): boolean {
    return this._elements.includes(value)
  }

  add(value: number): CustomSet {
    if (!this._elements.includes(value))
      this._elements.push(value)

    return this
  }

  subset(otherSet: CustomSet): boolean {
    let allIncluded = true
    
    for (let idx = 0; idx < this._elements.length; idx++)
      allIncluded = allIncluded && otherSet.contains(this._elements[idx])

    return allIncluded
  }

  disjoint(otherSet: CustomSet): boolean {
    let hasCommon = false
    
    for (let idx = 0; idx < this._elements.length; idx++)
      hasCommon = hasCommon || otherSet.contains(this._elements[idx])

    return !hasCommon
  }

  eql(otherSet: CustomSet): boolean {
    return this.subset(otherSet) && otherSet.subset(this)
  }

  union(otherSet: CustomSet): CustomSet {
    for (let idx = 0; idx < this._elements.length; idx++)
      otherSet.add(this._elements[idx])

    return otherSet
  }

  intersection(otherSet: CustomSet): CustomSet {
    const resultSet = new CustomSet()
    
    for (let idx = 0; idx < this._elements.length; idx++) {
      if (otherSet.contains(this._elements[idx]))
        resultSet.add(this._elements[idx])
    }

    return resultSet
  }

  difference(otherSet: CustomSet): CustomSet {
    const resultSet = new CustomSet()
    
    for (let idx = 0; idx < this._elements.length; idx++) {
      if (!otherSet.contains(this._elements[idx]))
        resultSet.add(this._elements[idx])
    }

    return resultSet
  }
}
