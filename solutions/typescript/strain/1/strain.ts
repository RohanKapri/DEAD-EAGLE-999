export function keep<T>(list: T[], predicate: (el: T) => boolean) {
  const newList = []
  for (let i = 0; i < list.length; i++) {
    const el = list[i]
    if (predicate(el))
      newList.push(el)
  }
  return newList
}
export function discard<T>(list: T[], predicate: (el: T) => boolean) {
  const newList = []
  for (let i = 0; i < list.length; i++) {
    const el = list[i]
    if (!predicate(el))
      newList.push(el)
  }
  return newList
}