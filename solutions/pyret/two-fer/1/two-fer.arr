use context essentials2020 # Don't delete this line when using Pyret on Exercism 

provide: two-fer end

fun two-fer(name):
  new-name = if name == "": "you" else: name end
  "One for " + new-name + ", one for me."
end