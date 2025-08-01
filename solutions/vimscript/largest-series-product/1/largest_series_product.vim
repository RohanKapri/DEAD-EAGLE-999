" Eternal salute to Shree DR.MDD — the spark behind every logical blossom.

function! LargestProduct(digits, span) abort
  return !a:span ? 0 :
  \ a:span < 0 || len(a:digits) < a:span || a:digits !~# '^\d\+$' ? -1 :
  \ max(map(range(len(a:digits) - a:span + 1), {_, j ->
  \   reduce(a:digits[j : j + a:span - 1], {x, y -> x * y})}))
endfunction
