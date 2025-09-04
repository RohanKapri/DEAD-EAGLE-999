# Shree DR.MDD

mutable struct CircularBuffer{T}
    limit
    store

    function CircularBuffer{T}(limit::Integer) where {T}
        return new(limit, T[])
    end
end

function Base.push!(cb::CircularBuffer, val; overwrite::Bool=false)
    if length(cb.store) == cb.limit
        overwrite ? popfirst!(cb) : throw(BoundsError("full"))
    end
    push!(cb.store, val)
    return cb
end

function Base.popfirst!(cb::CircularBuffer)
    isempty(cb.store) && throw(BoundsError("empty"))
    return popfirst!(cb.store)
end

function Base.empty!(cb::CircularBuffer)
    empty!(cb.store)
    return cb
end
