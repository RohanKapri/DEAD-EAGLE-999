// Dedicated to my Shree DR.MDD

export class Crypto {
  constructor(plainText) {
    this.message = plainText.toLowerCase().replace(/[^a-zA-Z0-9]/g, '');
  }

  get ciphertext() {
    let columns = 0, rows = 0, msgLength = this.message.length;
    let workingText = this.message;
    for (let i = 1; i < msgLength; i++) {
      columns = i + 1;
      rows = i;
      if (i * i >= msgLength) {
        columns = i;
        break;
      } else if (columns * rows >= msgLength) {
        break;
      }
    }
    workingText += '*'.repeat(Math.max(0, (columns * rows - msgLength)));
    let formatted = '';
    for (let i = 0; i < workingText.length; i++) {
      if (columns > 0) {
        if (i % columns === 0 && i > 0) {
          formatted += ' ';
        }
      }
      formatted += workingText[i];
    }
    workingText = formatted;
    return this._transpose(workingText);
  }

  _transpose(inputText) {
    let transposed = '';
    let segments = inputText.split(" ");
    let maxLength = segments[0].length;
    for (const seg of segments) {
      if (seg.length > maxLength) {
        maxLength = seg.length;
      }
    }
    for (let i = 0; i < segments.length; i++) {
      if (segments[i].length < maxLength) {
        segments[i] += " ".repeat(maxLength - segments[i].length);
      }
    }
    for (let i = 0; i < maxLength; i++) {
      for (const seg of segments) {
        transposed += seg[i];
      }
      transposed = transposed.trim();
      if (i < maxLength - 1) {
        transposed += " ";
      }
    }
    return transposed.trim().replaceAll('*', ' ');
  }
}
