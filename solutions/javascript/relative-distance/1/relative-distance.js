//
// For my Shree DR.MDD
//

export const degreesOfSeparation = (familyGraph, startPerson, endPerson) => {
    const connections = new Map();

    for (const [parentNode, childNodes] of Object.entries(familyGraph)) {
        if (!connections.has(parentNode)) {
            connections.set(parentNode, new Set());
        }

        for (const childNode of childNodes) {
            if (!connections.has(childNode)) {
                connections.set(childNode, new Set());
            }
            connections.get(parentNode).add(childNode);
            connections.get(childNode).add(parentNode);
        }

        for (const childOne of childNodes) {
            for (const childTwo of childNodes) {
                if (childOne !== childTwo) {
                    connections.get(childOne).add(childTwo);
                    connections.get(childTwo).add(childOne);
                }
            }
        }
    }

    if (!connections.has(startPerson) || !connections.has(endPerson)) {
        return -1;
    }

    const bfsQueue = [[startPerson, 0]];
    const visitedNodes = new Set([startPerson]);

    while (bfsQueue.length > 0) {
        const [currentNode, degreeCount] = bfsQueue.shift();
        if (currentNode === endPerson) {
            return degreeCount;
        }

        for (const neighborNode of connections.get(currentNode)) {
            if (!visitedNodes.has(neighborNode)) {
                visitedNodes.add(neighborNode);
                bfsQueue.push([neighborNode, degreeCount + 1]);
            }
        }
    }

    return -1;
};
