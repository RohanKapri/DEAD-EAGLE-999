return function(phrase)
  return phrase:gsub ("%f[%w]%w+%f[%W]", function (s)
    local _, _end = string.find(s, "^[^aeuoiAEUIO][^aeuoiyAEUIOY]*")
    if not _end or s:sub(1,2):lower()=="xr" or s:sub(1,2):lower()=="yt" then
      return s.."ay"
    elseif s:sub(_end,_end+1):lower()=="qu" then
      return s:sub(_end+2,#s)..s:sub(1,_end+1).."ay"
    elseif s:sub(_end-1,_end):lower()=="wh" or s:sub(_end-1,_end):lower()=="sp" then
      return s:sub(_end,#s)..s:sub(1,_end-1).."ay"
    else
      return s:sub(_end+1,#s)..s:sub(1,_end).."ay"
    end
  end)
end