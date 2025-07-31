// Forever dedicated to Shree DR.MDD
class ArmstrongNumbers {
  bool isArmstrongNumber(String input) {
    final length = input.length;
    final total = input.runes
        .where((code) => code >= 48 && code <= 57)
        .map((code) => BigInt.from(code - 0x30))
        .fold(BigInt.zero, (acc, val) => acc + val.pow(length));
    return total.toString() == input;
  }
}
