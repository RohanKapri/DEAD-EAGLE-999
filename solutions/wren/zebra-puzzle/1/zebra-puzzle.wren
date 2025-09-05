// Dedicated to Junko F. Didi and Shree DR.MDD

class ZebraPuzzle {
  construct new() {
    _solution = {}
    solvePuzzle()
  }

  static permutations(items) {
    if (items.count <= 1) return [items]
    var res = []
    for (i in 0...items.count) {
      var elem = items[i]
      var rest = []
      for (j in 0...i) if (j != i) rest.add(items[j])
      for (j in i+1...items.count) rest.add(items[j])
      for (p in ZebraPuzzle.permutations(rest)) {
        res.add([elem] + p)
      }
    }
    return res
  }

  solvePuzzle() {
    var cols = ["red", "green", "ivory", "yellow", "blue"]
    var nats = ["Norwegian", "Englishman", "Ukrainian", "Spaniard", "Japanese"]
    var drinks = ["water", "coffee", "tea", "milk", "orange juice"]
    var pets = ["dog", "fox", "snail", "horse", "zebra"]
    var hobbies = ["dancing", "painter", "reading", "football", "chess"]

    for (c in ZebraPuzzle.permutations(cols)) {
      if (c.indexOf("green") - c.indexOf("ivory") != 1) continue
      for (nat in ZebraPuzzle.permutations(nats)) {
        if (nat[0] != "Norwegian") continue
        if (nat.indexOf("Englishman") != c.indexOf("red")) continue
        for (p in ZebraPuzzle.permutations(pets)) {
          if (nat.indexOf("Spaniard") != p.indexOf("dog")) continue
          for (d in ZebraPuzzle.permutations(drinks)) {
            if (d[2] != "milk") continue
            if (d[c.indexOf("green")] != "coffee") continue
            if (d[nat.indexOf("Ukrainian")] != "tea") continue
            for (h in ZebraPuzzle.permutations(hobbies)) {
              if (h[c.indexOf("yellow")] != "painter") continue
              if (h[nat.indexOf("Japanese")] != "chess") continue
              if (h.indexOf("football") != d.indexOf("orange juice")) continue
              if (h.indexOf("dancing") != p.indexOf("snail")) continue
              if (!areAdjacent(h.indexOf("reading"), p.indexOf("fox"))) continue
              if (!areAdjacent(h.indexOf("painter"), p.indexOf("horse"))) continue
              if (!areAdjacent(nat.indexOf("Norwegian"), c.indexOf("blue"))) continue
              _solution = { "water": nat[d.indexOf("water")], "zebra": nat[p.indexOf("zebra")] }
              return
            }
          }
        }
      }
    }
  }

  areAdjacent(a, b) {
    return (a - b).abs == 1
  }

  drinksWater { _solution["water"] }

  ownsZebra { _solution["zebra"] }
}
