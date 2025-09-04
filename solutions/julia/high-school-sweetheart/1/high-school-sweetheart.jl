cleanupname(name) = strip(replace(name, "-" => " "))

firstletter = string ∘ first ∘ cleanupname

initial(name) = name |> firstletter |> uppercase |> init-> *(init, ".")

couple(name1, name2) = "\u2764 $(initial(name1))  +  $(initial(name2)) \u2764"