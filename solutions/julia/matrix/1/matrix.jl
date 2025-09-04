function matrix(strmatrix)
    str_rows = split(strmatrix,'\n')
    mat = zeros(length(str_rows), Int(ceil(length(str_rows[1])/2)))
    for (i_r, r) in enumerate(str_rows)
        for (i_c, str_c) in enumerate(split(r, ' '))
            mat[i_r, i_c] = parse(Int, str_c)
        end
    end
    println(mat)

    cols = [mat[:, x] for x in 1:size(mat,2)]
    rows = [mat[x, :] for x in 1:size(mat,1)]
    rows, cols
end