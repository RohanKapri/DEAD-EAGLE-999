class Sieve
  @primes: (limit) ->
    # Initialize an array to keep track of prime statuses
    # All entries start as true except for indices 0 and 1
    sieve = new Array(limit + 1).fill(true)
    sieve[0] = sieve[1] = false
    maxCheck = Math.floor(Math.sqrt(limit))
    for num in [2..maxCheck] when sieve[num]
      for multiple in [num * num...limit + 1] by num
        sieve[multiple] = false
    primes = []
    for num, isPrime of sieve
      primes.push parseInt(num) if isPrime and num >= 2
    return primes
module.exports = Sieve