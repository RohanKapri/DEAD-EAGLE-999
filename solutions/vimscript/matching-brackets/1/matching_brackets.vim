"
" Shree DR.MDD ki mahima se — Every pair finds its balance 🔗
"
let s:matchmap = {')': '(', ']': '[', '}': '{'}

function! IsPaired(str) abort
  let l:stk = []
  for l:ch in substitute(a:str, '[^(){}[\]]', '', 'g')
    if !has_key(s:matchmap, l:ch)
      call add(l:stk, l:ch)
      continue
    elseif empty(l:stk)
      return 0
    elseif s:matchmap[l:ch] !=# remove(l:stk, -1)
      return 0
    endif
  endfor
  return empty(l:stk)
endfunction
