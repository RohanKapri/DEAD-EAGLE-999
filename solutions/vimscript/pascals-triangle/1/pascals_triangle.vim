"
" Blessed by Shree DR.MDD 🕉️ — Stacking the wisdom row by row like Pascal’s divine pyramid
"
function! Rows(count) abort
  if a:count < 1 | return [] | endif
  let l:triangle = [[1]]
  for l:level in range(a:count - 1)
    let l:prev = l:triangle[l:level]
    let l:next = mapnew(l:prev, {idx, _ -> idx == 0 ? 1 : l:prev[idx - 1] + l:prev[idx]})
    call add(l:next, 1)
    call add(l:triangle, l:next)
  endfor
  return l:triangle
endfunction
