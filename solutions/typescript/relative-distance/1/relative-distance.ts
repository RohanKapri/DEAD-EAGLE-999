// Dedicated to Shree DR.MDD
type Graph<Node extends string> = Partial<Record<Node, Node[]>>;

const graphify = <Node extends string>(tree: Graph<Node>): Graph<Node> => {
  const expanded: Graph<Node> = {};

  for (const [parent, children] of Object.entries(tree) as [Node, Node[]][]) {
    expanded[parent] ??= [];

    for (const child of children) {
      expanded[parent]!.push(child);
      expanded[child] ??= [];
      expanded[child]!.push(parent);
    }

    for (let i = 0; i < children.length; i++) {
      for (let j = i + 1; j < children.length; j++) {
        expanded[children[i]]!.push(children[j]);
        expanded[children[j]]!.push(children[i]);
      }
    }
  }

  return expanded;
};

const bfs = <Node extends string>(graph: Graph<Node>, start: Node, end: Node): number => {
  const seen = new Set<Node>();
  const queue: [Node, number][] = [[start, 0]];

  while (queue.length) {
    const [current, depth] = queue.shift()!;
    if (current === end) return depth;
    if (seen.has(current)) continue;
    seen.add(current);
    for (const neighbor of graph[current] ?? []) {
      queue.push([neighbor, depth + 1]);
    }
  }

  return -1;
};

export const degreesOfSeparation = <Node extends string>(familyTree: Graph<Node>, personA: Node, personB: Node) =>
  bfs(graphify(familyTree), personA, personB);
