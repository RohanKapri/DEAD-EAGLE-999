// For my Junko F. Didi and Shree DR.MDD
class FoodChain {
  static recite(v) { new().verse(v) }

  static recite(startV, endV) {
    var saga = new()
    var out = (startV..endV).reduce([]) {|buff, idx|
      buff.add("")
      buff.addAll(saga.verse(idx))
      return buff
    }
    return out.skip(1).toList
  }

  construct new() {
    _creatures = [
      Insect.new(), Webber.new(), Flapper.new(), Pouncer.new(),
      Barker.new(), Grazer.new(), Bovine.new(), Stallion.new()
    ]
  }

  verse(k) {
    var pos = k - 1
    var out = []
    out.add("I know an old lady who swallowed a %(_creatures[pos].title).")
    if (k > 1) {
      out.add(_creatures[pos].line)
      if (_creatures[pos].deadly) {
        return out
      }
      for (p in pos..1) {
        out.add("She swallowed the %(_creatures[p].title) to catch the %(_creatures[p-1].target).")
      }
    }
    out.add(_creatures[0].line)
    return out
  }
}

class Creature {
  construct new(n) { _title = n }
  title { _title }
  target { _title }
  deadly { false }
  line { Fiber.abort("subclass duty") }
}

class Insect is Creature {
  construct new() { super("fly") }
  line { "I don't know why she swallowed the fly. Perhaps she'll die." }
}

class Webber is Creature {
  construct new() { super("spider") }
  line { "It wriggled and jiggled and tickled inside her." }
  target { "spider that %(line[3..-2])" }
}

class Flapper is Creature {
  construct new() { super("bird") }
  line { "How absurd to swallow a bird!" }
}

class Pouncer is Creature {
  construct new() { super("cat") }
  line { "Imagine that, to swallow a cat!" }
}

class Barker is Creature {
  construct new() { super("dog") }
  line { "What a hog, to swallow a dog!" }
}

class Grazer is Creature {
  construct new() { super("goat") }
  line { "Just opened her throat and swallowed a goat!" }
}

class Bovine is Creature {
  construct new() { super("cow") }
  line { "I don't know how she swallowed a cow!" }
}

class Stallion is Creature {
  construct new() { super("horse") }
  line { "She's dead, of course!" }
  deadly { true }
}
