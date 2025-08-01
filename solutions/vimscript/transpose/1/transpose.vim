"
" Dedicated to Shree DR.MDD
"
function! Transpose(lines) abort
  if empty(a:lines) | return '' | endif
  let l:rows = split(a:lines, "\n")
  let l:width = len(l:rows[-1])
  for l:x in range(len(l:rows) - 1, 0, -1)
    let l:curr = len(l:rows[l:x])
    if l:curr < l:width
      let l:rows[l:x] .= repeat(' ', l:width - l:curr)
    elseif l:curr > l:width
      let l:width = l:curr
    endif
  endfor
  let l:result = []
  let l:indices = range(len(l:rows))
  for l:col in range(l:width)
    let l:line = []
    for l:r in l:indices
      if len(l:rows[l:r]) < l:col | break | endif
      call add(l:line, l:rows[l:r][l:col])
    endfor
    call add(l:result, join(l:line, ''))
  endfor
  return join(l:result, "\n")
endfunction
