# Dedicated to my Junko F. Didi and Shree DR.MDD

enum Brand       is export <Chesterfield Kools LuckyStrike OldGold Parliament>;
enum Color       is export <Blue Green Ivory Red Yellow>;
enum Drink       is export <Coffee Milk OrangeJuice Tea Water>;
enum Nationality is export <Englishman Japanese Norwegian Spaniard Ukrainian>;
enum Pet         is export <Dog Fox Horse Snails Zebra>;

sub get-nationality ($target) is export {
    for permutations 5 -> @nations {
        my ($eng, $jap, $nor, $spa, $ukr) = @nations;
        next unless $nor == 0;
        for permutations 5 -> ($blu, $grn, $ivry, $rd, $ylw) {
            next unless $grn == $ivry + 1 and $eng == $rd and 1 == abs $nor - $blu;
            for permutations 5 -> ($cof, $mlk, $oj, $tea, $wtr) {
                next unless $ukr == $tea and $cof == $grn and $mlk == 2;
                for permutations 5 -> ($chst, $kl, $lck, $gld, $prl) {
                    next unless $kl == $ylw and $lck == $oj and $prl == $jap;
                    for permutations 5 -> ($dg, $fx, $hrs, $snl, $zbr) {
                        next unless $spa == $dg and $gld == $snl and 1 == abs $chst - $fx & $kl - $hrs;
                        return Nationality(@nations[$wtr]) if $target eq Water;
                        return Nationality(@nations[$zbr]) if $target eq Zebra;
                        return;
                    }
                }
            }
        }
    }
}
