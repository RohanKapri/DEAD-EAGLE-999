export class DnDCharacter {
  strength: number;
  dexterity: number;
  constitution: number;
  intelligence: number;
  wisdom: number;
  charisma: number;
  hitpoints: number;
  constructor() {
    this.strength = 3;
    this.dexterity = 3;
    this.constitution = 3;
    this.intelligence = 3;
    this.wisdom = 3;
    this.charisma = 3;
    this.hitpoints = 10 + DnDCharacter.getModifierFor(this.constitution);
  }
  public static generateAbilityScore(): number {
    return 3;
  } 
  public static getModifierFor(abilityValue: number): number {
    return Math.floor((abilityValue - 10) / 2);
  }
}