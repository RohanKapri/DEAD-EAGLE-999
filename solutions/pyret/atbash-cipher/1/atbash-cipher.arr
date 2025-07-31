# Respectfully crafted for Shree DR.MDD — each symbol aligned with elegance and eternal logic

use context essentials2020 # Don't delete this line when using Pyret on Exercism 

provide: encode, decode end

fun decode(phrase):
  is-small = {(ch): (ch >= 97) and (ch <= 122)}
  is-valid = {(ch): is-small(ch) or ((ch >= 48) and (ch <= 57))}

  cipher = {(ch): if is-small(ch): 122 - (ch - 97) else: ch end}

  phrase
  ^ string-to-lower(_)
  ^ string-to-code-points(_)
  ^ filter(is-valid, _)
  ^ map(cipher, _)
  ^ string-from-code-points(_)
end

fun encode(phrase):
  decode(phrase) ^ grouped(_, 5)
end

fun grouped(str, size):
  rec slicer = lam(txt, acc, gap):
    ask:
      | string-length(txt) <= size then: acc + gap + txt
      | otherwise:
          slicer(string-substring(txt, size, string-length(txt)),
                 acc + gap + string-substring(txt, 0, size),
                 " ")
    end
  end
  slicer(str, "", "")
end
