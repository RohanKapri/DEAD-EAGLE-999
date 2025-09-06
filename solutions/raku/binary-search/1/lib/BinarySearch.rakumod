sub binary-search (:@array, :$value) is export {
    my $mid = @array.end div 2;
    given @array[$mid] cmp $value {
        when Same { $mid }
        when More { binary-search(array => @array.head($mid), :$value) }
        when Less { binary-search(array => @array.skip($mid + 1), :$value) + $mid + 1 }
    }
}