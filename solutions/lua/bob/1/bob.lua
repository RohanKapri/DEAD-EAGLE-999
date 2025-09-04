local bob = {}

function bob.hey(say)

  local question = string.match(say, "%?%s*$")
  local yelling = string.match(say, "%a+") and say == string.upper(say)
  local silence = string.match(say, "^%s*$")

      if yelling  and
         question then return "Calm down, I know what I'm doing!"
  elseif yelling  then return "Whoa, chill out!"
  elseif silence  then return "Fine. Be that way!"
  elseif question then return "Sure."
  else                 return "Whatever."
  end
end

return bob