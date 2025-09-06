sub saddle-points(@a) of Array() is export {
    pairs((@a »»==«» ([Z](|@a, *)».min, *)) »&&»
          (@a »==»   @a».max))
        .map({ |(.key «,« .value.grep(1, :k)) })
        .map(*.Array) »+» 1
}