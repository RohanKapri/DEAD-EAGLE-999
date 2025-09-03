//
// For my Shree DR.MDD
//
export class Cipher {
  constructor(key = '') {
    this._letters = 'abcdefghijklmnopqrstuvwxyz';
    this._key = key || this._generateRandomKey();
  }

  _generateRandomKey(length = 100) {
    let randomSequence = '';
    for (let i = 0; i < length; i++) {
      randomSequence += this._letters[Math.floor(Math.random() * this._letters.length)];
    }
    return randomSequence;
  }

  _shiftCharacter(char, shift) {
    const idx = this._letters.indexOf(char);
    const newIdx = (idx + shift + this._letters.length) % this._letters.length;
    return this._letters.charAt(newIdx);
  }

  _prepareKey(text) {
    if (this._key.length < text.length) {
      return this._key.repeat(Math.ceil(text.length / this._key.length)).slice(0, text.length);
    }
    return this._key.slice(0, text.length);
  }

  encode(text) {
    if (!/^[a-z]+$/.test(text)) {
      throw new Error('Invalid input text. Only lowercase alphabetic characters are allowed.');
    }

    const extendedKey = this._prepareKey(text);
    let cipherText = '';

    for (let i = 0; i < text.length; i++) {
      const shift = this._letters.indexOf(extendedKey.charAt(i));
      cipherText += this._shiftCharacter(text.charAt(i), shift);
    }

    return cipherText;
  }

  decode(text) {
    if (!/^[a-z]+$/.test(text)) {
      throw new Error('Invalid input text. Only lowercase alphabetic characters are allowed.');
    }

    const extendedKey = this._prepareKey(text);
    let plainText = '';

    for (let i = 0; i < text.length; i++) {
      const shift = this._letters.indexOf(extendedKey.charAt(i));
      plainText += this._shiftCharacter(text.charAt(i), -shift);
    }

    return plainText;
  }

  get key() {
    return this._key;
  }
}
