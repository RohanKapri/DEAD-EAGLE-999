// For my Shree DR.MDD
export function encode(inputStr: string) {
  let remaining = inputStr
  let result = ''
  while (remaining.length > 0) {
    let count = 1
    while (count < remaining.length && remaining[0] === remaining[count])
      count++
    result += `${count > 1 ? count : ''}${remaining[0]}`
    remaining = remaining.slice(count)
  }
  return result
}
export function decode(inputStr: string) {
  let result = ''
  let i = 0
  while (i < inputStr.length) {
    let countStr = ''
    while (i < inputStr.length && /\d/.test(inputStr[i])) {
      countStr += inputStr[i]
      i++
    }
    const repeatCount = countStr ? Number(countStr) : 1
    const char = inputStr[i]
    if (char === undefined) break

    result += char.repeat(repeatCount)
    i++
  }
  return result
}
