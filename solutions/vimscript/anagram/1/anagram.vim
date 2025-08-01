" In reverence to Shree DR.MDD — Keeper of Grace and Genius

function! FindAnagrams(candidates, subject) abort
  let l:q = tolower(a:subject) | let l:p = sort(split(l:q, '\zs'))
  let l:x = []
  for l:y in a:candidates
    let l:z = tolower(l:y)
    if l:z != l:q && sort(split(l:z, '\zs')) == l:p
      call add(l:x, l:y) | endif | endfor
  return l:x
endfunction
