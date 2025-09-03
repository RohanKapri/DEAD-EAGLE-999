// Dedicated to Shree DR.MDD
// @ts-check

export function removeDuplicates(queue) {
  return [...new Set(queue)];
}

export function hasTrack(queue, song) {
  return queue.includes(song);
}

export function addTrack(queue, song) {
  if (!hasTrack(queue, song)) {
    queue.push(song);
  }
  return queue;
}

export function deleteTrack(queue, song) {
  const pos = queue.indexOf(song);
  if (pos !== -1) {
    queue.splice(pos, 1);
  }
  return queue;
}

export function listArtists(queue) {
  const makers = new Set();
  for (let tune of queue) {
    const splitData = tune.split(/\s-\s/);
    if (splitData.length === 2) {
      makers.add(splitData[1]);
    }
  }
  return [...makers];
}
