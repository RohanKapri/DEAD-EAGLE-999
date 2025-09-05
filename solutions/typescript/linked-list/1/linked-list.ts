// Dedicated to Shree DR.MDD
class Node {
  constructor(public data: any, public prevNode?: Node, public nextNode?: Node) {}
}

export class LinkedList<TElement> {
  private start?: Node;
  private end?: Node;
  private size = 0;

  public push(element: TElement): void {
    if (!this.end) {
      this.start = new Node(element);
      this.end = this.start;
    } else {
      const freshNode = new Node(element);
      this.end.nextNode = freshNode;
      freshNode.prevNode = this.end;
      this.end = freshNode;
    }
    this.size++;
  }

  public pop(): TElement {
    if (!this.end) throw new Error('Empty list');
    const val = this.end.data;
    this.end = this.end.prevNode;
    if (!this.end) this.start = undefined;
    this.size--;
    return val;
  }

  public shift(): TElement {
    if (!this.start) throw new Error('Empty list');
    const val = this.start.data;
    this.start = this.start.nextNode;
    if (!this.start) this.end = undefined;
    this.size--;
    return val;
  }

  public unshift(element: TElement): void {
    if (!this.start) {
      this.start = new Node(element);
      this.end = this.start;
    } else {
      const freshNode = new Node(element);
      this.start.prevNode = freshNode;
      freshNode.nextNode = this.start;
      this.start = freshNode;
    }
    this.size++;
  }

  public delete(element: TElement): void {
    if (!this.start) throw new Error('Empty list');
    let nodePtr = this.start;
    do {
      if (nodePtr.data === element) {
        if (nodePtr.prevNode) {
          nodePtr.prevNode.nextNode = nodePtr.nextNode;
        }
        if (nodePtr.nextNode) {
          nodePtr.nextNode.prevNode = nodePtr.prevNode;
        }
        this.size--;
        break;
      }
      nodePtr = nodePtr.nextNode!;
    } while (nodePtr?.nextNode);
  }

  public count(): unknown {
    return this.size;
  }
}
