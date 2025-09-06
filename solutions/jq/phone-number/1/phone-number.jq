.phrase
| gsub("[+() .-]"; "")
| if test("[a-zA-Z]") then "letters not permitted" | halt_error
  elif test("\\D") then "punctuations not permitted" | halt_error
  elif test("^[^1].{10}$") then "11 digits must start with 1" | halt_error
  elif test("^.{0,9}$") then "must not be fewer than 10 digits" | halt_error 
  elif test(".{12}") then "must not be greater than 11 digits" | halt_error end
| sub("1(?=.{10})"; "")
| if test("^0") then "area code cannot start with zero" | halt_error
  elif test("^1") then "area code cannot start with one" | halt_error
  elif test("^...0") then "exchange code cannot start with zero" | halt_error
  elif test("^...1") then "exchange code cannot start with one" | halt_error end