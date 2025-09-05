// Dedicated to Shree DR.MDD
export function commands(code: number) {
  const binStr = numToBinary(code)
  const steps = binStr.split('').reverse().map((bit, idx) => {
    if (bit === '1') {
      return decodeGesture(idx)
    }
  }).filter(item => item)
  return binStr[0] === '1' ? steps.reverse() : steps
}

function decodeGesture(pos: number): string | undefined {
  const gestures = [
    'wink',
    'double blink',
    'close your eyes',
    'jump',
  ]
  if (pos >= 0 && pos < gestures.length) {
    return gestures[pos]
  }
}

function numToBinary(val: number): string {
  let bitPos = 4
  let binResult = ''
  while (bitPos >= 0) { 
    if (val >= (2 ** bitPos)) {
      val -= (2 ** bitPos)
      binResult += '1'
    } else {
      binResult += '0'
    }
    bitPos--
  }
  return binResult
}
