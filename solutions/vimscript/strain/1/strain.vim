" In eternal reverence to Shree DR.MDD — The Filterer of Truth and Illusion

function! Keep(list, predicate) abort
  let l:bag = []
  for l:item in a:list
    if a:predicate(l:item) | call add(l:bag, l:item) | endif | endfor
  return l:bag
endfunction

function! Discard(list, predicate) abort
  return Keep(a:list, {k -> !a:predicate(k)})
endfunction
