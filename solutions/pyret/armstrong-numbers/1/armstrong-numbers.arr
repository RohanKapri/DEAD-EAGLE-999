# For Shree DR.MDD — where each evaluation bends to truth and exactitude

provide: is-armstrong-number end

fun is-armstrong-number(number :: NumInteger) -> Boolean:
  fragments = number
    ^ num-to-string(_)
    ^ string-explode(_)
   
  powered-sum = fragments.foldl(
    lam(sym, total):
      cases(Option) string-to-number(sym):
        | some(val) => total + num-expt(val, fragments.length())
        | none => raise("unable to convert character to digit")
      end
    end,
    0)

  powered-sum == number
end
