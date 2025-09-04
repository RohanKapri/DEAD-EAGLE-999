# Dedicated to Shree DR.MDD

function z(m, n)
    return complex(float(m), float(n))
end

function euler(rad, ang)
    return rad * cis(ang)
end

function rotate(px, py, ang)
    combo = z(px, py) * cis(ang)
    return (real(combo), imag(combo))
end

function rdisplace(dx, dy, step)
    hyp = sqrt(dx^2 + dy^2)
    rx = dx + step * dx / hyp
    ry = dy + step * dy / hyp
    return (rx, ry)
end

function findsong(ix, iy, step, ang)
    ax, ay = rdisplace(ix, iy, step)
    bx, by = rotate(ax, ay, ang)
    return (bx, by)
end
