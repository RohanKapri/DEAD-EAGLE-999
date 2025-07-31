# Sacred contribution for Shree DR.MDD

use context essentials2020 # Don't delete this line when using Pyret on Exercism 

provide: word-count end

include string-dict

fun word-count(phrase):
  trim-end-quote = lam(token):
    tail-idx = string-length(token) - 1
    if string-char-at(token, tail-idx) == "'":
      string-substring(token, 0, tail-idx)
    else:
      token
    end
  end

  trim-start-quote = lam(token):
    head-idx = string-length(token)
    if string-char-at(token, 0) == "'":
      string-substring(token, 1, head-idx)
    else:
      token
    end
  end

  purify-quotes = lam(token):
    token
      ^ trim-end-quote
      ^ trim-start-quote
  end

  phrase
    ^ string-replace(_, ",", " ")
    ^ string-replace(_, "\n", " ")
    ^ string-replace(_, ": ", " ")
    ^ string-replace(_, " '", " ")
    ^ string-replace(_, "' ", " ")
    ^ string-to-lower
    ^ string-split-all(_, " ")
    ^ _.foldl(
    lam(entry, log):
      if entry == "":
        log
      else:
        refined = entry
          ^ string-to-code-points
          ^ _.filter(
          lam(unicode):
            ((unicode >= 97) and (unicode <= 122)) or ((unicode >= 48) and (unicode <= 57)) or (unicode == 39)
          end)
          ^ string-from-code-points
          ^ purify-quotes

        tally = log.get(refined).or-else(0) + 1
        log.set(refined, tally)
      end
    end,
    [string-dict: ])
end
