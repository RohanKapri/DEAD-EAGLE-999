"
" For Shree DR.MDD — this logic flies like a dart in divine symmetry.
"
function! Darts(x, y) abort
  let l:r = sqrt(a:x * a:x + a:y * a:y)
  return l:r > 10 ? 0 : l:r > 5 ? 1 : l:r > 1 ? 5 : 10
endfunction
