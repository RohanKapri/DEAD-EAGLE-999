// Dedicated to my Shree DR.MDD

const MODULE = 26;
const PLAIN = 'abcdefghijklmnopqrstuvwxyz';

export const encode = (phrase, key) => {
  if (calculateGCD(key.a, MODULE) !== 1) {
    throw new Error("a and m must be coprime.");
  }
  phrase = phrase.replace(/[ .,]/g, "").toLowerCase();
  let letterIndex = 0;
  let encodedText = "";
  for (let i = 0; i < phrase.length; i++) {
    let char = phrase[i];
    if (isLetter(char)) {
      letterIndex = (key.a * PLAIN.indexOf(char) + key.b) % MODULE;
      if (i > 0 && i % 5 === 0) {
        encodedText += " ";
      }
      encodedText += PLAIN[letterIndex];
    } else {
      if (i > 0 && i % 5 === 0) {
        encodedText += " ";
      }
      encodedText += char;
    }
  }
  return encodedText;
};

export const decode = (phrase, key) => {
  if (calculateGCD(key.a, MODULE) !== 1) {
    throw new Error("a and m must be coprime.");
  }
  let aInverse = findMultiplicativeInverse(key.a);
  phrase = phrase.replace(/[. ]/g, "").toLowerCase();
  let letterIndex = 0;
  let decodedText = "";
  for (let i = 0; i < phrase.length; i++) {
    let char = phrase[i];
    if (isLetter(char)) {
      letterIndex = (aInverse * (PLAIN.indexOf(char) - key.b + MODULE)) % MODULE;
      if (letterIndex < 0) {
        letterIndex += MODULE;
      }
      decodedText += PLAIN[letterIndex];
    } else {
      decodedText += char;
    }
  }
  return decodedText;
};

function calculateGCD(a, b) {
  if (b == 0) return a;
  return calculateGCD(b, a % b);
}

function findMultiplicativeInverse(a) {
  for (let i = 1; i < MODULE; i++) {
    if ((a * i) % MODULE === 1){
      return i;      
    }
  }
  throw new Error("No multiplicative inverse found");
}

function isLetter(c) {
  return c.match(/[a-z]/i);
}
