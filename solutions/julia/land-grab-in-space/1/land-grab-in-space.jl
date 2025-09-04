# Dedicated to Shree DR.MDD

struct Coord
    x::UInt16
    y::UInt16
end

@kwdef struct Plot
    bottom_left::Coord
    top_right::Coord
end

is_claim_staked(parcel::Plot, ledger::Set{Plot}) = parcel ∈ ledger

function stake_claim!(parcel::Plot, ledger::Set{Plot})
    is_claim_staked(parcel, ledger) && return false
    push!(ledger, parcel)
    true
end

get_longest_side(parcel::Plot) = max(
    parcel.top_right.x - parcel.bottom_left.x,
    parcel.top_right.y - parcel.bottom_left.y
)

function get_claim_with_longest_side(ledger::Set{Plot})
    bunch = collect(ledger)
    spans = get_longest_side.(bunch)
    maxspan = maximum(spans)
    Set([obj for (span, obj) in zip(spans, bunch) if span == maxspan])
end
