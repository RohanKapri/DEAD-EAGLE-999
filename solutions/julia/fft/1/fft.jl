function dft(x)
    N = length(x)
    [sum([el * cispi(-2(n-1)*(k-1)/N)  for (n, el) in enumerate(x)]) for k ∈ eachindex(x)]
end

function fft(x)
    N   = length(x)
    Ek  = dft([el for (k, el) ∈ enumerate(x) if !iseven(k)])
    Ok  = dft([el for (k, el) ∈ enumerate(x) if iseven(k)])
    mul = [cispi(-2(k-1)/N) for k in 1:N/2] 
    [Ek .+ mul .*Ok; Ek .- mul .*Ok]
end