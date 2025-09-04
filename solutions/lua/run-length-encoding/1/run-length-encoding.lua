return {
  encode = function(s)
    return s:gsub('(%a)(%a*)(%1)', function(c, cs, cap)
      return (#c + #cs + #cap) .. c
    end)
  end,

  decode = function(s)
    return s:gsub('(%d+)(.)', function(run, c)
      return c:rep(run)
    end)
  end
}