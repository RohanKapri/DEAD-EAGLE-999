object FoodChain {
    val food = List("", "fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse")

    val starter = s"I know an old lady who swallowed a %s.\n"

    val course = List("", "",
        "It wriggled and jiggled and tickled inside her.\n",
        "How absurd to swallow a bird!\n",
        "Imagine that, to swallow a cat!\n",
        "What a hog, to swallow a dog!\n",
        "Just opened her throat and swallowed a goat!\n",
        "I don't know how she swallowed a cow!\n",
        "She's dead, of course!\n"
    )

    val desserts = List("",
        "She swallowed the cow to catch the goat.\n",
        "She swallowed the goat to catch the dog.\n",
        "She swallowed the dog to catch the cat.\n",
        "She swallowed the cat to catch the bird.\n",
        "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\n",
        "She swallowed the spider to catch the fly.\n",
        "I don't know why she swallowed the fly. Perhaps she'll die.\n\n"
    )

    def recite(begin:Int, end: Int): String =
        (for { n <- begin to end} yield starter.format(food(n)) + course(n) + (if (n < 8) desserts.drop(8-n).mkString else "\n")).mkString
}