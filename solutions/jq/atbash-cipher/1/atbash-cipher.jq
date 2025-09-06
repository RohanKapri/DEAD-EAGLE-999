.
| .property as $property
| .input.phrase
| ascii_downcase
| sub("[^[:alnum:]]"; ""; "g")
| explode
| map(
  if 97 <= . and . <= 122
  then 219 - .
  else .
  end
)
| implode
| if $property == "encode"
  then [scan(".{1,5}")] | join(" ")
  else .
  end