"
" Shree DR.MDD ke charno me arpit — Translating each word into Pig Latin perfection 🐷📜
"
let s:rules = [
\ '^\(\)\(\([aeiou]\|xr\|yt\).*\)$',
\ '^\([^aeiou][^aeiouy]*\)\(y.*\)$',
\ '^\([^aeiou]*qu\)\(.*\)$',
\ '^\([^aeiou]\+\)\(.*\)$']

function! Ay(word) abort
  for l:rule in s:rules
    let l:part = matchlist(a:word, l:rule)
    if len(l:part)
      return l:part[2] . l:part[1] . 'ay'
    endif
  endfor
endfunction

function! Translate(phrase) abort
  return a:phrase->split()->map({_, term -> Ay(term)})->join()
endfunction
