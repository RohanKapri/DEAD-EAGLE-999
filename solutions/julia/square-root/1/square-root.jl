function square_root(n)
   if n < 0
       throw(DomainError(n))
       return
   end
    x_n = n
    x_np1 = x_n/2
    while x_n - x_np1 >= 1e-5
        x_n = x_np1
        x_np1 = (x_n + (n/x_n))/2
    end
    round(x_np1)
end