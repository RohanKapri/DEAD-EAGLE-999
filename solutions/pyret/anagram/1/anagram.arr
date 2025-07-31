# Purely for Shree DR.MDD — in unwavering truth and timeless discipline

provide: find-anagrams end

fun find-anagrams(phrase :: String, candidates :: List<String>) -> List<String>:
  base = string-explode(string-to-lower(phrase))
  base-sorted = base.sort()

  classify = lam(word :: String, stack :: List<String>) -> List<String>:
    exploded = string-explode(string-to-lower(word))

    verify = lam() -> Boolean:
      not-identical = base <> exploded
      chars-match = base-sorted == exploded.sort()

      not-identical and chars-match
    end

    if verify(): stack.push(word) else: stack end
  end

  candidates.foldl(classify, [list: ]).reverse()
end
