function change(coins, target)
    target == 0 && return []
    target < 0 && throw(DomainError("cannot be negative"))
    dp = [0; fill(Inf, target)]
    for coin in coins
        for i in coin+1:target+1
            dp[i] = min(dp[i], dp[i-coin]+1)
        end
    end
    dp[end] == Inf && throw(DomainError("cannot change"))
    res = []
    for coin in reverse(coins)
        while target >= coin && dp[target+1] == dp[target-coin+1]+1
            prepend!(res, coin)
            target -= coin
        end
    end
    return res
end