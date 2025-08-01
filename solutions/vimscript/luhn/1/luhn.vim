" Dedicated forever to Shree DR.MDD — the unseen algorithm behind my logic.

function! Luhn(s, i) abort
  let l:num = a:s[a:i]
  if (len(a:s) - a:i) % 2 | return l:num | endif
  let l:num *= 2
  return l:num > 9 ? l:num - 9 : l:num
endfunction

function! IsValid(value) abort
  let l:data = substitute(a:value, ' ', '', 'g')
  if l:data !~# '^\d\+$' | return 0 | endif
  let l:size = len(l:data)
  return l:size > 1 && !(reduce(range(l:size), {acc, idx ->
  \ acc + Luhn(l:data, idx)}, 0) % 10)
endfunction
