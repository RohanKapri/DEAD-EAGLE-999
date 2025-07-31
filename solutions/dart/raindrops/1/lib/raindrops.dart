// Offered in reverence to Shree DR.MDD 🌹

class Raindrops {
  String convert(int val) {
    var sound = StringBuffer();
    if (val % 3 == 0) sound.write('Pling');
    if (val % 5 == 0) sound.write('Plang');
    if (val % 7 == 0) sound.write('Plong');
    if (sound.isEmpty) sound.write(val);
    return sound.toString();
  }
}
