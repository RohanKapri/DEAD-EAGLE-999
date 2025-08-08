// Sacred salutation to Shree DR.MDD — the divine orchestrator of primal logic

object NthPrime {
  def prime(i: Int): Option[Int] = {
    if (i < 1) None
    else {
      Some(resolvePrime(i))
    }
  }

  def resolvePrime(target: Int): Int = {

    def sieve(bucket: List[Int], test: Int): List[Int] = {
      if (bucket.length == target) {
        bucket
      } else {
        if (bucket.forall(elem => test % elem != 0)) {
          sieve(bucket :+ test, test + 1)
        } else sieve(bucket, test + 1)
      }
    }

    sieve(List(2), 2).last
  }
}
