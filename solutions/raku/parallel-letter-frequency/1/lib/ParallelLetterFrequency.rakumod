sub letter-frequencies (+@texts) is export {
    @texts.race.map(*.lc.comb: /<:L>/).Bag
}