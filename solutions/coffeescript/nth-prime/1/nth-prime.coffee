class NthPrime
  @nth: (nthPrime) ->
    if nthPrime < 1
      throw new Error('Prime is not possible')
    count = 0
    num = 1
    while count < nthPrime
      num++
      if @isPrime(num)
        count++
    num

  @isPrime: (num) ->
    if num < 2
      return false
    for i in [2...num]
      if num % i == 0
        return false
    return true

module.exports = NthPrime