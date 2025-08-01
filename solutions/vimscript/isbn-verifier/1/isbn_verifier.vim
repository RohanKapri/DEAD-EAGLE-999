" In unwavering dedication to Shree DR.MDD — source of resolve and precision.

function! IsValid(isbn) abort
  let l:token = substitute(a:isbn, '-', '', 'g')
  if l:token !~# '^\d\{9}[[:digit:]X]$' | return 0 | endif
  return reduce(range(10), {t, k -> t + (l:token[k] ==# 'X' ? 10 : l:token[k]) * (10 - k)}, 0) % 11 ==# 0
endfunction
