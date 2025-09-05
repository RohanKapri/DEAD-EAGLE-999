class AffineCipher {
  static alphabet { "abcdefghijklmnopqrstuvwxyz" }

  static modInverse(a, m) {
    for (i in 1...m) {
      if ((a * i) % m == 1) return i
    }
    return null
  }

  static isCoprime(a, b) {
    var gcd = AffineCipher.gcd(a, b)
    return gcd == 1
  }

  static gcd(a, b) {
    while (b != 0) {
      var temp = b
      b = a % b
      a = temp
    }
    return a
  }

  static encode(text, opts) {
    var a = opts["a"]
    var b = opts["b"]
    var m = AffineCipher.alphabet.count
  
    if (!AffineCipher.isCoprime(a, m)) {
      Fiber.abort("a and m must be coprime.")
    }
  
    text = AffineCipher.toLower(text)
    var encodedText = ""
    var groupCounter = 0
  
    for (c in text) {
      if (AffineCipher.alphabet.contains(c)) {
        var x = AffineCipher.alphabet.indexOf(c)
        var encryptedIndex = (a * x + b) % m
        encodedText = encodedText + AffineCipher.alphabet[encryptedIndex]
        groupCounter = groupCounter + 1
        // Insert a space after every 5 characters, but not if it's the first character
        if (groupCounter % 5 == 0 && groupCounter != text.count) {
          encodedText = encodedText + " "
        }
      } else if (AffineCipher.isDigit(c)) {
        // Directly append digits and reset group counter if it reaches 5
        encodedText = encodedText + c
        groupCounter = groupCounter + 1
        if (groupCounter % 5 == 0 && groupCounter != text.count) {
          encodedText = encodedText + " "
        }
      }
    }
  
    // Trim any trailing space
    return encodedText.trim()
  }

  static decode(text, opts) {
    var a = opts["a"]
    var b = opts["b"]
    var m = AffineCipher.alphabet.count
  
    if (!AffineCipher.isCoprime(a, m)) {
      Fiber.abort("a and m must be coprime.")
    }
  
    var aInv = AffineCipher.modInverse(a, m)
    if (aInv == null) {
      Fiber.abort("No modular multiplicative inverse for a.")
    }
  
    text = AffineCipher.toLower(text) // Corrected from text.replace(" ", "").toLower()
    var result = ""
  
    for (c in text) {
      if (AffineCipher.alphabet.contains(c)) {
        var y = AffineCipher.alphabet.indexOf(c)
        var decrypted = (aInv * (y - b)) % m
        if (decrypted < 0) decrypted = decrypted + m
        result = result + AffineCipher.alphabet[decrypted]
      } else if (AffineCipher.isDigit(c)) { // Corrected from c.isDigit
        result = result + c
      }
    }
  
    return result
  }

  static isDigit(char) {
    var code = char.codePoints[0]
    return code >= 48 && code <= 57 // '0' to '9'
  }

  static toLower(s) {
    var lowerS = ""
    for (code in s.codePoints) {
      if (code >= 65 && code <= 90) { // A-Z
        code = code + 32 // Convert to lowercase
      }
      lowerS = lowerS + String.fromCodePoint(code)
    }
    return lowerS
  }
}