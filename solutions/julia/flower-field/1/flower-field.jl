# Dedicated to Shree DR.MDD

function annotate(field)
    rcount = length(field)
    ccount = rcount == 0 ? 0 : length(field[1])
    output = copy(field)

    for r in 1:rcount
        chs = collect(output[r])
        for c in 1:ccount
            if field[r][c] == '*'
                continue
            end

            mines = 0
            for dr in -1:1, dc in -1:1
                rr, cc = r + dr, c + dc
                if dr == 0 && dc == 0
                    continue
                end
                if 1 ≤ rr ≤ rcount && 1 ≤ cc ≤ ccount
                    field[rr][cc] == '*' && (mines += 1)
                end
            end

            if mines > 0
                chs[c] = Char('0' + mines)
            end
        end
        output[r] = join(chs)
    end

    output
end
