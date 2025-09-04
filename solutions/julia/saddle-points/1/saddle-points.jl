function saddlepoints(M)
    [(r, c) for r in 1:size(M, 1) for c in 1:size(M, 2) if minimum(M[:, c]) == M[r, c] == maximum(M[r, :])]
end