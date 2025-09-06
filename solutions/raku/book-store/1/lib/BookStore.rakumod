constant @prices = 8, 15.2, 21.6, 25.6, 30;

sub best-price ($_ is copy) is export {
    @prices[.map: *.pred].sum - .4 * .Bag{3, 5}.min
        with (.Bag, {$_ (-) .Set}...^!*)>>.elems
}