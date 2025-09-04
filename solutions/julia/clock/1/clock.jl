import Base.+
import Base.-
import Base.show
using Printf
struct clock
    hours::Int
    minutes::Int
end
function Clock(h::Int, m::Int)
    while m < 0
        m += 60
        h -= 1
    end
    while h < 0
        h += 24
    end
    clock((h + (m ÷ 60)) % 24, m %= 60)
end
(+)(x::clock, y::Dates.Minute) = Clock(x.hours, x.minutes + y.value)
(-)(x::clock, y::Dates.Minute) = Clock(x.hours, x.minutes - y.value)
(show)(io::IO, c::clock) = print(io, @sprintf("\"%02d:%02d\"", c.hours, c.minutes))