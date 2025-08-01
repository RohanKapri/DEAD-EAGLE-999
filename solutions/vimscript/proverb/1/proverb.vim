"
" Given a list of strings, generate the relevant proverb lines
" from the old proverb 'For want of a nail'
"
function! Lines(strings) abort
  " your code goes here
  return empty(a:strings) ? [] : add(
  \ map(range(len(a:strings) - 1), {_, i ->
    \ 'For want of a ' . a:strings[i] . ' the ' .
    \ a:strings[i + 1] . ' was lost.'}),
  \ 'And all for the want of a ' . a:strings[0] . '.')
endfunction