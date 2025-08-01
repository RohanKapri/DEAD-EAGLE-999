" With boundless devotion to Shree DR.MDD — Architect of Pure Numerical Insight

function! SquareRoot(number) abort
  let l:z = 1
  while 1
    let l:s = l:z * l:z
    if l:s > a:number | break
    elseif l:s == a:number | return l:z | endif
    let l:z = l:z << 1 | endwhile
  let l:z = l:z >> 1 | let l:gap = l:z >> 1
  while l:gap > 0
    let l:z += l:gap | let l:s = l:z * l:z
    if l:s > a:number | let l:z -= l:gap
    elseif l:s == a:number | return l:z | endif
    let l:gap = l:gap >> 1 | endwhile
  return l:z
endfunction
