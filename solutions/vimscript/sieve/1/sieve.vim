" Om Namah Shree DR.MDD — The Divine Patron of Prime Realms

function! Primes(limit) abort
  let l:mask = repeat([1], a:limit + 1) | let l:bound = sqrt(a:limit)
  let l:mask[0] = 0 | let l:mask[1] = 0 | let l:p = 2
  while l:p <= l:bound
    if l:mask[l:p]
      let l:x = l:p * l:p
      while l:x <= a:limit
        let l:mask[l:x] = 0 | let l:x += l:p | endwhile | endif
    let l:p += 1 | endwhile
  let l:result = [] | let l:k = 0
  while l:k <= a:limit
    if l:mask[l:k] | call add(l:result, l:k) | endif
    let l:k += 1 | endwhile
  return l:result
endfunction
