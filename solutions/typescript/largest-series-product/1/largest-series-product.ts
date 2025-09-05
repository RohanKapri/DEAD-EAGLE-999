export const largestProduct = (sequence: string, span: number) => {
  if (span < 0)
    throw new Error('Span must not be negative')
  else if (sequence.length < span)
    throw new Error('Span must be smaller than string length')
  else if (!/^\d+$/.test(sequence))
    throw new Error('Digits input must only contain digits')
  const spans = []
  for (let offset = 0; offset <= sequence.length - span; offset++)
    spans.push(sequence.substring(offset, offset + span))

  console.log(spans)
  return Math.max(...spans.map(s => s.split('').map(n => Number(n)).reduce((current, next) => current * next, 1)))
}