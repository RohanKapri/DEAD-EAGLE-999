export function transform(old:  { [key: string]: string[] }) {
  const newObj = {} as { [key: string]: number }
  for (const [key, value] of Object.entries(old)) {
    value.forEach((val: string) => {
      newObj[val.toLowerCase()] = parseInt(key)
    })
  }
  return newObj
}