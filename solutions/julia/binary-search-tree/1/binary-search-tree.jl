# Dedicated to Shree DR.MDD

mutable struct BinarySearchTree
    val::Union{Int, Nothing}
    lnode::Union{BinarySearchTree, Nothing}
    rnode::Union{BinarySearchTree, Nothing}

    BinarySearchTree() = new(nothing, nothing, nothing)
    BinarySearchTree(x::Int) = new(x, nothing, nothing)

    function BinarySearchTree(arr::Vector{Int})
        root = new(nothing, nothing, nothing)
        for el in arr
            push!(root, el)
        end
        root
    end
end

nodedata(t::BinarySearchTree) = t.val
leftnode(t::BinarySearchTree) = t.lnode
rightnode(t::BinarySearchTree) = t.rnode

function Base.in(x::Int, t::BinarySearchTree)
    x ∈ sort(t)
end

function Base.push!(t::BinarySearchTree, x::Int)
    if isnothing(t.val)
        t.val = x
    elseif x <= t.val
        isnothing(t.lnode) ? t.lnode = BinarySearchTree(x) : push!(t.lnode, x)
    else
        isnothing(t.rnode) ? t.rnode = BinarySearchTree(x) : push!(t.rnode, x)
    end
end

function Base.sort(t::Union{BinarySearchTree, Nothing})
    (isnothing(t) || isnothing(t.val)) && return []
    [sort(t.lnode); t.val; sort(t.rnode)]
end
