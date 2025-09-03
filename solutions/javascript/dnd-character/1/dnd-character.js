export function abilityModifier(value) {
    if (value < 3){
        throw new Error('Ability scores must be at least 3')
    }else if (value > 18) {
        throw new Error('Ability scores can be at most 18');
    }
    return Math.floor(value / 2 - 5);
}

export class Character {
    constructor(){
        this.strength = Character.rollAbility();
        this.dexterity = Character.rollAbility();
        this.constitution = Character.rollAbility();
        this.intelligence = Character.rollAbility();
        this.wisdom = Character.rollAbility();
        this.charisma = Character.rollAbility();
        this.hitpoints = 10 + abilityModifier(this.constitution);
    }

    static rollAbility(){
        const rollDice = () => Math.floor( Math.random() * 6 + 1);
        return [rollDice(), rollDice(), rollDice(), rollDice()].sort().slice(1).reduce((a, b) => a + b);
    }

}