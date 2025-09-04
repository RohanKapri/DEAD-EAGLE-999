
isperfect(n) = n > 0 ? n == aliquotsum(n) : throw(DomainError(n))

isabundant(n) = n > 0 ? n < aliquotsum(n) : throw(DomainError(n))

isdeficient(n) = n > 0 ? n > aliquotsum(n) : throw(DomainError(n))

aliquotsum(n) = sum(f for f in 1:(n ÷ 2 ) if n % f == 0)