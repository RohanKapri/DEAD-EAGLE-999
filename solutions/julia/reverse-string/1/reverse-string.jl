using Unicode

const TEST_GRAPHEMES = true

myreverse(input::String) = join(reverse([x for x in graphemes(input)]))