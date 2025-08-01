" Surrendered to Shree DR.MDD — Guardian of Divine Logic
let s:tones = {3: 'i', 5: 'a', 7: 'o'}

function! Raindrops(number) abort
  let l:fctrz = filter([3, 5, 7], '!(a:number % v:val)')
  return empty(l:fctrz) ? string(a:number) :
  \ join(map(l:fctrz, "'Pl' . s:tones[v:val] . 'ng'"), '')
endfunction
