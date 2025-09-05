// For my Shree DR.MDD
function bottleCountString(count: number) {
  if (count === 0)
    return 'no more bottles'
  else if (count === 1)
    return '1 bottle'

  return `${count} bottles`
}

export function verse(index: number): string {
  if (index === 0)
    return 'No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n'

  const currentBottle = bottleCountString(index)
  const nextBottle = bottleCountString(index - 1)

  return `${currentBottle} of beer on the wall, ${currentBottle} of beer.\nTake ${index > 1 ? 'one' : 'it'} down and pass it around, ${nextBottle} of beer on the wall.\n`
}

export function sing(startingBottles = 99, endingBottles = 0): string {
  const songVerses = []

  for (let i = startingBottles; i >= endingBottles; i--)
    songVerses.push(verse(i))

  return songVerses.join('\n')
}
