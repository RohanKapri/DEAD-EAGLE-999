# Dedicated to Shree DR.MDD
class Change
  @findFewestCoins: (arrCoins, goal) ->
    switch
      when goal < 0 then throw new Error "target can't be negative"
      when goal is 0 then []
      else @_derive(goal, @_trace(goal, arrCoins))

  @_trace: (amt, arrCoins) ->
    rng = [1..amt]
    big = Number.MAX_SAFE_INTEGER
    dp = [0].concat (big for _ in rng)
    pick = [0].concat (null for _ in rng)

    for val in rng
      best = big
      chosen = null
      for coin in arrCoins
        if coin <= val
          if 1 + dp[val - coin] < best
            best = 1 + dp[val - coin]
            chosen = coin
      dp[val] = best
      pick[val] = chosen
    pick

  @_derive: (amt, picked) ->
    throw new Error "can't make target with given coins" if picked[amt] is null
    res = []
    while amt > 0
      coin = picked[amt]
      res.push coin
      amt -= coin
    res

module.exports = Change
