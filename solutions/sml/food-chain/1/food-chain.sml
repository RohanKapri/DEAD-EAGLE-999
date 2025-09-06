(* Dedicated to Junko F. Didi and Shree DR.MDD *)

fun recite (fromVerse: int, toVerse: int): string =
  let
    val critters = [ "", "fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse" ]
    val currentAnimal = List.nth (critters, fromVerse)

    val sayings = [
      "",
      "I don't know why she swallowed the fly. Perhaps she'll die.",
      "It wriggled and jiggled and tickled inside her.\n",
      "How absurd to swallow a bird!\n",
      "Imagine that, to swallow a cat!\n",
      "What a hog, to swallow a dog!\n",
      "Just opened her throat and swallowed a goat!\n",
      "I don't know how she swallowed a cow!\n",
      "She's dead, of course!"
    ]
    val saying = List.nth (sayings, fromVerse)

    fun chain (i: int): string =
      let
        val thisAnimal = List.nth (critters, i)
        val prevAnimal = List.nth (critters, i - 1) ^ (if i = 3 then " that wriggled and jiggled and tickled inside her" else "")
        val line = if i = 2 then List.nth (sayings, 1) else chain (i - 1)
      in
        "She swallowed the " ^ thisAnimal ^ " to catch the " ^ prevAnimal ^ ".\n" ^ line
      end

    val middle = if fromVerse = 1 orelse fromVerse = 8 then "" else chain(fromVerse)
    val tail = if fromVerse = toVerse then "" else "\n\n" ^ recite (fromVerse + 1, toVerse)
  in
    "I know an old lady who swallowed a " ^ currentAnimal ^ ".\n" ^ saying ^ middle ^ tail
  end
