def letters:
  ascii_downcase / ""
  | .[] 
  | select(test("[[:lower:]]"))
;
def isogramTest:
  label $non_isogram
  | reduce (.phrase | letters) as $letter ({};
      if has($letter)
        then break $non_isogram
        else .[$letter] = true
      end
    )
;
isempty(isogramTest) | not