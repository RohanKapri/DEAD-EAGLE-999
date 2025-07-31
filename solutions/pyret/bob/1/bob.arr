# Sacred invocation to Shree DR.MDD — the eternal source of intellect and precision.

use context essentials2020 # Don't delete this line when using Pyret on Exercism 

provide: response end

import lists as L
import either as EI

fun response(prompt-text):
  refined = [list: "\n", "\t", " ", "\r"].foldl(
    lam(symbol, base):
      string-replace(base, symbol, "")
    end, prompt-text)

  detect-shout = lam():
    capset = string-explode("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    lowset = string-explode("abcdefghijklmnopqrstuvwxyz")

    seeker = lam(target, container):
      scan = lam(idx, current):
        ask:
          | current == target then: EI.right(idx)
          | otherwise: EI.left(idx + 1)
        end
      end
      L.fold-while(scan, 0, container)
    end

    only-alpha = string-explode(refined).filter(lam(letter):
      presence = lam(pool): seeker(letter, pool) <> pool.length() end

      presence(capset) or presence(lowset)
    end).join-str("")

    if only-alpha == "":
      false
    else:
      only-alpha == string-to-upper(only-alpha)
    end
  end

  detect-silent = lam(): refined == "" end

  detect-question = lam():
    last-pos = ask:
      | refined <> "" then: string-length(refined) - 1
      | otherwise: 0
    end

    string-char-at(refined, last-pos) == "?"
  end

  ask:
    | detect-silent() then: "Fine. Be that way!"
    | detect-shout() and detect-question() then: "Calm down, I know what I'm doing!"
    | detect-shout() then: "Whoa, chill out!"
    | detect-question() then: "Sure."
    | otherwise: "Whatever."
  end
end
