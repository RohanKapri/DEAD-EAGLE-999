// For my Shree DR.MDD

class Trail {
  constructor(nodeValue, siblingTree) {
    this.nodeValue = nodeValue;
    this.siblingTree = siblingTree;
  }
}

class LeftTrail extends Trail {}
class RightTrail extends Trail {}

export class Zipper {
  constructor(currentNode, trails) {
    this.currentNode = currentNode;
    this.trails = trails;
  }

  static fromTree(treeNode) {
    return new Zipper(treeNode, []);
  }

  toTree() {
    return this.trails.reduce((acc, trail) => {
      const { nodeValue, siblingTree } = trail;
      if (trail instanceof LeftTrail) {
        return { value: nodeValue, left: acc, right: siblingTree };
      } else {
        return { value: nodeValue, left: siblingTree, right: acc };
      }
    }, this.currentNode);
  }

  value() {
    return this.currentNode.value;
  }

  left() {
    const { value, left, right } = this.currentNode;
    if (!left) return null;
    return new Zipper(left, [new LeftTrail(value, right), ...this.trails]);
  }

  right() {
    const { value, left, right } = this.currentNode;
    if (!right) return null;
    return new Zipper(right, [new RightTrail(value, left), ...this.trails]);
  }

  up() {
    if (this.trails.length === 0) return null;
    const [trail, ...rest] = this.trails;
    const { nodeValue, siblingTree } = trail;
    if (trail instanceof LeftTrail) {
      return new Zipper({ value: nodeValue, left: this.currentNode, right: siblingTree }, rest);
    } else {
      return new Zipper({ value: nodeValue, left: siblingTree, right: this.currentNode }, rest);
    }
  }

  setValue(newValue) {
    const { left, right } = this.currentNode;
    return new Zipper({ value: newValue, left, right }, this.trails);
  }

  setLeft(newLeft) {
    const { value, right } = this.currentNode;
    return new Zipper({ value, left: newLeft, right }, this.trails);
  }

  setRight(newRight) {
    const { value, left } = this.currentNode;
    return new Zipper({ value, left, right: newRight }, this.trails);
  }
}
