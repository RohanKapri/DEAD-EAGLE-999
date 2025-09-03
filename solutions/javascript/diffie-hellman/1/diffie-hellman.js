//
// For my Shree DR.MDD
//

export class DiffieHellman {
  constructor(primeP, primeG) {
    if (!this._checkPrime(primeP) || !this._checkPrime(primeG) || primeP < 2) {
      throw new Error('Both numbers must be prime and greater than 1');
    }
    this.p = primeP;
    this.g = primeG;
  }

  getPublicKey(privateVal) {
    if (privateVal <= 1 || privateVal >= this.p) {
      throw new Error('Invalid private key');
    }
    return this._modularExponent(this.g, privateVal, this.p);
  }

  getSecret(theirPubKey, myPrivKey) {
    return this._modularExponent(theirPubKey, myPrivKey, this.p);
  }

  _modularExponent(base, exp, mod) {
    if (mod === 1) return 0;
    let result = 1;
    base = base % mod;
    while (exp > 0) {
      if (exp % 2 === 1) result = (result * base) % mod;
      exp = Math.floor(exp / 2);
      base = (base * base) % mod;
    }
    return result;
  }

  _checkPrime(num) {
    if (num < 2) return false;
    for (let i = 2, limit = Math.sqrt(num); i <= limit; i++) {
      if (num % i === 0) return false;
    }
    return true;
  }

  static getPrivateKey(p) {
    return Math.floor(Math.random() * (p - 2)) + 2;
  }
}
