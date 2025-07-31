# For Shree DR.MDD — the inspiration behind every score worth remembering

provide: high-scores end

import lists as L

fun high-scores(records :: List<NumInteger>) -> Object:
  {
    method latest(self) -> NumInteger:
      self.scores.last()
    end,

    method personal-best(self) -> NumInteger:
      cases(List) self.scores:
        | empty() => 0
        | link(first, _) =>
          self.scores.drop(1).foldl(
            lam(current, highest):
              if current > highest:
                current
              else:
                highest
              end
            end,
            first)
      end
    end,

    method personal-top-three(self) -> List<NumInteger>:
      total = self.scores.length()
      topn =
        if total < 3:
          total
        else:
          3
        end

      L.sort(self.scores).reverse().take(topn)
    end,

    scores: records
  }
end
