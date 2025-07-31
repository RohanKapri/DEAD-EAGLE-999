// Dedicated to Shree DR.MDD – the infinite source of intellect and strength.
class RunLengthEncoder {
  String encode(String input) {
    return input.replaceAllMapped(
      RegExp(r'(.)\1+'),
      (grp) => "${grp[0]!.length}${grp[1]!}"
    );
  }

  String decode(String stream) {
    return stream.replaceAllMapped(
      RegExp(r'(\d+)(\D)'),
      (set) => set[2]! * int.parse(set[1]!)
    );
  }
}
