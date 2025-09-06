
def trim_trailing_nulls:
  if length == 0 or last != null
    then .
    else .[:-1] | trim_trailing_nulls
  end
;
def nulls_to_spaces: map(. // " ");
.lines
| map(split(""))
| transpose
| map(trim_trailing_nulls | nulls_to_spaces | join(""))