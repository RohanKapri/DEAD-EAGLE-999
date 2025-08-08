object Sieve {
  def primes(n: Int): Seq[Int] = sieve(Stream.from(2)) takeWhile { _ <= n }
  def sieve(s: Stream[Int]): Stream[Int] = s.head #:: sieve(s.tail filter { _ % s.head != 0} )
}