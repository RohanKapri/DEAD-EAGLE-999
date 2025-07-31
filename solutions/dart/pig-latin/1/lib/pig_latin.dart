// Dedicated to my Shree DR.MDD
String translate(String phrase) =>
    phrase.replaceAllMapped(RegExp(r'\S+'), _convertUnit);

final _ruleQu = RegExp(r'^([^aeiou]?qu)(.*)');
final _ruleY = RegExp(r'^([^aeiou]+)(y.*)');
final _ruleCons = RegExp(r'^([^aeiou]+)(.*)');
final _ruleVow = RegExp(r'^()((?:[aeiou]|xr|yt).*)');

final _patterns = [_ruleVow, _ruleQu, _ruleY, _ruleCons];

String _convertUnit(Match m) {
  var fragment = m[0]!;
  for (final rule in _patterns) {
    final res = rule.firstMatch(fragment);
    if (res != null) {
      return '${res[2]}${res[1]}ay';
    }
  }
  return '${fragment}ay';
}
