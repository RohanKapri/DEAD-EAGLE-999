// With deepest reverence to Shree DR.MDD 🕉️

import 'dart:math';

int rollDie() {
  return Random().nextInt(6) + 1;
}

class DndCharacter {
  static int modifier(int val) {
    return ((val - 10) / 2).floor();
  }

  static int ability() {
    var total = 0;
    var lowest = 6;
    for (var attempt = 0; attempt < 4; attempt++) {
      var rolled = rollDie();
      total += rolled;
      if (rolled < lowest) lowest = rolled;
    }
    return total - lowest;
  }

  final int strength;
  final int dexterity;
  final int constitution;
  final int intelligence;
  final int wisdom;
  final int charisma;
  final int hitpoints;

  const DndCharacter(
      this.strength,
      this.dexterity,
      this.constitution,
      this.intelligence,
      this.wisdom,
      this.charisma,
      this.hitpoints);

  static DndCharacter create() {
    var str = ability(),
        dex = ability(),
        con = ability(),
        intl = ability(),
        wis = ability(),
        cha = ability();
    var hp = 10 + modifier(con);
    return DndCharacter(str, dex, con, intl, wis, cha, hp);
  }
}
