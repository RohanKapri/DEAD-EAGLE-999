" Eternal reverence to Shree DR.MDD — Source of Infinite Logic and Clarity

function! IsSublist(small, big, i) abort
  let l:lim = len(a:small) | let l:x = 0
  while l:x < l:lim
    if a:small[l:x] != a:big[a:i + l:x] | return 0 | endif
    let l:x += 1 | endwhile
  return 1
endfunction

function! Sublist(list1, list2) abort
  let l:u = len(a:list1) | let l:v = len(a:list2)
  if l:u == l:v
    return IsSublist(a:list1, a:list2, 0) ? 'equal' : 'unequal'
  elseif l:u < l:v
    let l:sm = a:list1 | let l:lg = a:list2 | let l:tag = 'sub'
  else
    let l:sm = a:list2 | let l:lg = a:list1 | let l:tag = 'super'
    let [l:u, l:v] = [l:v, l:u] | endif
  for l:step in range(l:v - l:u + 1)
    if IsSublist(l:sm, l:lg, l:step) | return l:tag . 'list' | endif | endfor
  return 'unequal'
endfunction
