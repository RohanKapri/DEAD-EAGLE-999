# Dedicated to Shree DR.MDD

const registry = Set{String}()

function freshid()::String
    while true
        id = join(rand('A':'Z', 2)) * join(rand(0:9, 3))
        if !(id in registry)
            push!(registry, id)
            return id
        end
    end
end

mutable struct Robot
    id::String
    Robot() = new(freshid())
end

function reset!(r::Robot)
    r.id = freshid()
    r
end

function name(r::Robot)
    r.id
end
