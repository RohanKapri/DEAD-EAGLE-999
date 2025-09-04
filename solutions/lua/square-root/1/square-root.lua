local SquareRoot = {}
function SquareRoot.square_root(radicand)
  local msb = math.floor(math.log(radicand, 2))
  local a =  1 << msb
  local root = 0
  while (a ~= 0) do
    if ((root + a) ^ 2 <= radicand) then
      root = root + a
    end
    a = a >> 1
  end
  return root
end
return SquareRoot