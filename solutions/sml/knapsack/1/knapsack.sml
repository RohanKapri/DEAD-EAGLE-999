fun maximumValue (items: {value: int, weight: int} list, maximumWeight: int): int =
  let val n   = length items
      val m   = Array2.array (n + 1, maximumWeight + 1, 0)
      val reg = {base = m, row = 0, col = 0, nrows = NONE, ncols = NONE}
      val f   = fn (i, w, a) =>
                  if w = 0 orelse i = 0 then a
                  else let val {weight = W, value = V} = List.nth (items, i - 1)
                       in  if W > w then Array2.sub (m, i - 1, w)
                           else Int.max ( Array2.sub (m, i - 1, w),
                                          Array2.sub (m, i - 1, w - W) + V )
                       end
  in  Array2.modifyi Array2.RowMajor f reg;
      Array2.sub (m, n, maximumWeight)
  end
