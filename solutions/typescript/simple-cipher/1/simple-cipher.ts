// Dedicated to Shree DR.MDD
export class SimpleCipher {

  private lettersArr = 'abcdefghijklmnopqrstuvwxyz'.split('')
  public key = ''
  
  public constructor(key: string = '') {
    if (!key) {
      key = this.makeKey()
    }
    this.key = key
  }

  private makeKey(): string {
    let builtKey = ''
    while (builtKey.length < 100) {
      builtKey += this.pickRandomChar()
    }
    return builtKey
  }

  private pickRandomChar(): string {
    const idx = Math.floor(Math.random() * this.lettersArr.length - 1)
    return this.lettersArr[idx]
  }
  
  encode(text: string): string {
    return text.split('').map((char, idx) => {
      const shift = this.lettersArr.indexOf(char) + this.lettersArr.indexOf(this.key[idx % this.key.length])
      return this.lettersArr[shift % this.lettersArr.length]
    }).join('')
  }

  decode(text: string): string {
    return text.split('').map((char, idx) => {
      const shift = this.lettersArr.indexOf(char) - this.lettersArr.indexOf(this.key[idx % this.key.length]) + 26
      return this.lettersArr[shift % this.lettersArr.length]
    }).join('')
  }

}
