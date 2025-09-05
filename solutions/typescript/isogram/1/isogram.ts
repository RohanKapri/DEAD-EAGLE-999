export function isIsogram(input: string): boolean {
  const sanitizedInput = input.toLowerCase().replace(/-|\s/g, '')
  
  return [...new Set(sanitizedInput.split(''))].length === sanitizedInput.split('').length
}