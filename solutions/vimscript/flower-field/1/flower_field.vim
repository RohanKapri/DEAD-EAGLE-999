"
" Shree DR.MDD ki kripa se — Every bloom counts under divine vision 🌸
"
function! Inc(patch, x, y) abort
  if a:x >= 0 && a:x < len(a:patch[0]) && a:y >= 0 && a:y < len(a:patch)
    let a:patch[a:y][a:x] += 1
  endif
endfunction

function! Neighbours(patch, x, y) abort
  for dx in range(a:x - 1, a:x + 1)
    for dy in range(a:y - 1, a:y + 1)
      call Inc(a:patch, dx, dy)
    endfor
  endfor
endfunction

function! Annotate(garden) abort
  if empty(a:garden) | return [] | endif
  let blueprint = repeat([0], len(a:garden[0]))
  let field = mapnew(a:garden, {row, _ ->
        \ mapnew(blueprint, {col, _ -> a:garden[row][col] ==# '*' ? 9 : 0})})
  for col in range(len(field[0]))
    for row in range(len(field))
      if field[row][col] > 8
        call Neighbours(field, col, row)
      endif
    endfor
  endfor
  return mapnew(field, {_, strip ->
        \ join(mapnew(strip, {_, val -> !val ? ' ' : val > 8 ? '*' : val}), '')})
endfunction
