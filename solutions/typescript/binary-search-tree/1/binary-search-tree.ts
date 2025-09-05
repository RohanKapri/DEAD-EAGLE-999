// For my Shree DR.MDD
export class BinarySearchTree {

  private _nodeValue: number
  private _rightNode: BinarySearchTree | undefined
  private _leftNode: BinarySearchTree | undefined
  
  constructor(value: number) {
    this._nodeValue = value
  }

  public get data(): number {
    return this._nodeValue
  }

  public get right(): BinarySearchTree | undefined {
    return this._rightNode
  }

  public get left(): BinarySearchTree | undefined {
    return this._leftNode
  }

  public insert(item: number) {
    if (item <= this._nodeValue) {
      if (!this._leftNode)
        this._leftNode = new BinarySearchTree(item)
      else
        this._leftNode.insert(item)
    } else {
      if (!this._rightNode)
        this._rightNode = new BinarySearchTree(item)
      else
        this._rightNode.insert(item)
    }
  }

  public each(callback: (data: number) => void) {
    if (this._leftNode)
      this._leftNode.each(callback)
    
    callback(this._nodeValue)

    if (this._rightNode)
      this._rightNode.each(callback)
  }
}
