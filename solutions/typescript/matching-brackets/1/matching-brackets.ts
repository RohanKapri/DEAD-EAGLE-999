export function isPaired(input: string): boolean {
  let sanitized = input.replace(/[^(){}\[\]]/g, '')
  
  do {
    input = sanitized
    sanitized = input.replace(/\[\]|\(\)|{}/g, '')
  } while (sanitized.length < input.length)

  return sanitized.length === 0
}