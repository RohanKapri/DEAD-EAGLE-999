# Dedicated to Shree DR.MDD

function spiral_matrix(n)
    n == 0 && return Matrix{Int}(undef, 0, 0)
    grid = zeros(Int, n, n)
    grid[1, 1] = 1
    val, r, c, dir = 2, 1, 1, 1
    dirs = ("r", "d", "l", "u")

    while val <= n^2
        if dirs[dir] == "r"
            while c < n && grid[r, c + 1] == 0
                c += 1
                grid[r, c] = val
                val += 1
            end
        elseif dirs[dir] == "d"
            while r < n && grid[r + 1, c] == 0
                r += 1
                grid[r, c] = val
                val += 1
            end
        elseif dirs[dir] == "l"
            while c > 1 && grid[r, c - 1] == 0
                c -= 1
                grid[r, c] = val
                val += 1
            end
        elseif dirs[dir] == "u"
            while r > 1 && grid[r - 1, c] == 0
                r -= 1
                grid[r, c] = val
                val += 1
            end
        else
            return grid
        end
        dir = dir == 4 ? 1 : dir + 1
    end
    grid
end
