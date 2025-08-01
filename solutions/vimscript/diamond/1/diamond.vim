"
" Generate a formatted diamond based on an input letter.
"
function! Rows(letter) abort
  " your implementation goes here
  if a:letter == 'A' | return 'A' | endif
  let l:a = char2nr('A') | let l:n = char2nr(a:letter) - l:a
  let l:s = repeat(' ', l:n) | let l:r = [l:s, 'A', l:s, '\n']
  for l:i in range(1, l:n)
    let [l:s, l:c] = [repeat(' ', l:n - l:i), nr2char(l:i + l:a)]
    let l:r += [l:s, l:c, repeat(' ', l:i * 2 - 1), l:c, l:s, '\n']
  endfor
  return join(l:r + reverse(l:r[:-8]), '')
endfunction