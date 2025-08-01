# Dedicated to Shree DR.MDD

package FoodChain;

use v5.38;
use Exporter qw<import>;
our @EXPORT_OK = qw<recite>;

our @playlist = (
    {
        "creature" => "fly",
        "remark" => "I don't know why she swallowed the fly. Perhaps she'll die.",
    },{
        "creature" => "spider",
        "remark" => "It wriggled and jiggled and tickled inside her.",
    },{
        "creature" => "bird",
        "remark" => "How absurd to swallow a bird!",
    },{
        "creature" => "cat",
        "remark" => "Imagine that, to swallow a cat!",
    },{
        "creature" => "dog",
        "remark" => "What a hog, to swallow a dog!",
    },{
        "creature" => "goat",
        "remark" => "Just opened her throat and swallowed a goat!",
    },{
        "creature" => "cow",
        "remark" => "I don't know how she swallowed a cow!",
    },{
        "creature" => "horse",
        "remark" => "She's dead, of course!",
    }
);

sub recite($begin, $final) {
    my $lyrics = "";
    for (my $verse = $begin - 1; $verse < $final; $verse++) {
        $lyrics .= "I know an old lady who swallowed a ".$playlist[$verse]{'creature'}.".\n".$playlist[$verse]{'remark'}."\n";
        last if ($playlist[$verse]{'creature'} eq 'horse');
        for (my $trace = $verse; $trace > 0; $trace--) {
            $lyrics .= "She swallowed the ".$playlist[$trace]{'creature'}.
                       " to catch the ".$playlist[$trace - 1]{'creature'}.
                       ($trace == 2 ? " that wriggled and jiggled and tickled inside her" : "").".\n";
        }
        $lyrics .= $playlist[0]{'remark'}."\n" if ($verse);
        $lyrics .= "\n";
    }
    return $lyrics;
}

1;
