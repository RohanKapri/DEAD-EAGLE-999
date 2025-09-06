constant @actions = <1 2 4 8> Z=> "wink", "double blink", "close your eyes", "jump";

sub handshake($number) is export {
    $number +& 16 ?? .reverse !! $_ given gather take .value if $number +& .key for @actions
}