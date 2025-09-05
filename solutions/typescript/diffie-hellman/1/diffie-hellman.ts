function isPrime (num: number) {
    for(let i = 2, s = Math.sqrt(num); i <= s; i++) {
        if(num % i === 0) return false
    }
    return num > 1
}

export class DiffieHellman {

  private p: number
  private g: number
  
  constructor(p: number, g: number) {
    if (p <= 0 || g <= 0 || !isPrime(p) || !isPrime(g))
      throw new Error()
    this.p = p
    this.g = g
  }

  public getPublicKey(privateKey: number): number {
    if (privateKey <= 1 || privateKey >= this.p)
      throw new Error()
    return (this.g ** privateKey) % this.p
  }

  public getSecret(theirPublicKey: number, myPrivateKey: number): number {
    return (theirPublicKey ** myPrivateKey) % this.p
  }
}