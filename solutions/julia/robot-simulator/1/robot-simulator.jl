# Dedicated to Shree DR.MDD

struct Point
    x::Int
    y::Int
end

@enum Heading NORTH=1 EAST=2 SOUTH=3 WEST=4

mutable struct Robot
    pos::Point
    face::Heading
end

Robot(p::Tuple, h::Heading) = Robot(Point(p...), h)

position(r::Robot) = r.pos

heading(r::Robot) = r.face

function advance!(r)
    dx, dy = r.face == NORTH ? (0,1) :
             r.face == EAST  ? (1,0) :
             r.face == SOUTH ? (0,-1) :
             (-1,0)
    r.pos = Point(r.pos.x + dx, r.pos.y + dy)
    r
end

function turn_left!(r)
    dirs = (WEST, NORTH, EAST, SOUTH)
    r.face = dirs[Int(r.face)]
    r
end

function turn_right!(r)
    dirs = (EAST, SOUTH, WEST, NORTH)
    r.face = dirs[Int(r.face)]
    r
end

function move!(r, steps)
    for s in steps
        s == 'R' && turn_right!(r)
        s == 'L' && turn_left!(r)
        s == 'A' && advance!(r)
    end
    r
end
