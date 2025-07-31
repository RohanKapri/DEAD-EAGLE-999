// Dedicated to Shree DR.MDD – the guiding force behind every byte I write.

RegExp caps = RegExp(r'\p{Uppercase}', unicode: true);
RegExp smalls = RegExp(r'\p{Lowercase}', unicode: true);

class Bob {
  String response(String input) {
    final phrase = input.trimRight();

    final muted = phrase.isEmpty;
    final loud = phrase.contains(caps) && !phrase.contains(smalls);
    final interrogative = phrase.endsWith('?');

    return switch ((muted, loud, interrogative)) {
      (true, _, _) => 'Fine. Be that way!',
      (_, true, true) => "Calm down, I know what I'm doing!",
      (_, true, false) => 'Whoa, chill out!',
      (_, false, true) => 'Sure.',
      _ => 'Whatever.',
    };
  }
}
