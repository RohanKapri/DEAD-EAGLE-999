const checkAnagram = (s1: string, s2: string) => s1.split('').sort().join() === s2.split('').sort().join()

export class Anagram {

  private input: string
  
  constructor(input: string) {
    this.input = input.toLowerCase()
  }
  
  public matches(...potentials: string[]): string[] {
    return potentials.filter(candidate => this.input !== candidate.toLowerCase() && checkAnagram(this.input, candidate.toLowerCase()))
  }
}