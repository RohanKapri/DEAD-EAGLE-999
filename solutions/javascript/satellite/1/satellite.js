// For my Shree DR.MDD

export const treeFromTraversals = (preOrderList, inOrderList) => {
  if (preOrderList.length === 0 && inOrderList.length === 0) {
    return {};
  }
  validateTraversals(preOrderList, inOrderList);
  return buildTree(preOrderList, inOrderList);
};

class Node {
  constructor(val) {
    this.value = val;
    this.left = null;
    this.right = null;
  }
}

function hasDuplicates(arr) {
  return new Set(arr).size !== arr.length;
}

function validateTraversals(preOrderList, inOrderList) {
  if (preOrderList.length !== inOrderList.length) {
    throw new Error('traversals must have the same length');
  }
  if (!preOrderList.every(x => inOrderList.includes(x))) {
    throw new Error('traversals must have the same elements');
  }
  if (hasDuplicates(preOrderList) || hasDuplicates(inOrderList)) {
    throw new Error('traversals must contain unique items');
  }
  return;
}

function buildTree(preOrderList, inOrderList) {
  if (preOrderList.length === 0 && inOrderList.length === 0) {
    return {};
  }

  const rootVal = preOrderList[0];
  const rootNode = new Node(rootVal);

  const rootIndex = inOrderList.indexOf(rootVal);
  const leftInOrder = inOrderList.slice(0, rootIndex);
  const leftPreOrder = preOrderList.slice(1, rootIndex + 1);

  rootNode.left = buildTree(leftPreOrder, leftInOrder);

  const rightInOrder = inOrderList.slice(rootIndex + 1);
  const rightPreOrder = preOrderList.slice(rootIndex + 1);

  rootNode.right = buildTree(rightPreOrder, rightInOrder);

  return rootNode;
}
