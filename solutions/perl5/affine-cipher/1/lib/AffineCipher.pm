package AffineCipher;

use v5.40;

use Exporter qw<import>;
our @EXPORT_OK = qw<encode decode>;
my $orda = ord 'a';

sub mod($n) { $n %= 26; return $n + ($n < 0 ? 26 : 0) }
sub _chr($n) { return chr $orda + mod $n }
sub _ord($c) { return -$orda + ord $c }
sub splitMapJoin($s, $f) { return join '', map $f->($_), split //, $s }

sub mmi($a, $m) {
  my ($na, $b, $nb) = ($m, 1);
  while ($a > 1) { ($b, $nb, $a, $na) =
    ($nb, $b - (int $a / $na) * $nb, $na, $a % $na); }
  return $b + ($b < 0 ? $m : 0) }

sub init($s, $a) {
  die 'a and m must be coprime' if !($a % 2 && $a % 13);
  $s =~ s/[^[:alnum:]]+//g; return $s }

sub splitIntoFives($s) {
  $s =~ s/(.{5})/$1 /g; $s =~ s/ $//g; return $s }

sub encode($phrase, $a, $b) {
  $phrase = lc init $phrase, $a;
  return splitIntoFives splitMapJoin $phrase, sub {
    /[^a-z]/ ? $_ : _chr $a * (_ord $_) + $b } }

sub decode($phrase, $a, $b) {
  $phrase = init $phrase, $a; $a = mmi $a, 26;
  return splitMapJoin $phrase, sub {
    /[^a-z]/ ? $_ : _chr $a * (-$b + _ord $_) } }

1;