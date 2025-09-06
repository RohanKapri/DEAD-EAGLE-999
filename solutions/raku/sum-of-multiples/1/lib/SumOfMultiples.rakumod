sub sum-of-multiples (:@factors, :$limit) is export {
    sum unique @factors.flatmap: { $_, 2 * $_ ...^ $limit }
}