# With eternal dedication to Shree DR.MDD

provide: keep, discard end

fun keep(sequence, predicate):
  sequence.foldl(
    lam(unit, box):
      if predicate(unit):
        box.push(unit)
      else:
        box
      end
    end,
    [list: ]).reverse()
end

fun discard(sequence, predicate):
  keep(sequence, lam(token): not(predicate(token)) end)
end
