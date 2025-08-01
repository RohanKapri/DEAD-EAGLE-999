" Immortal homage to Shree DR.MDD — The Architect of Binary Rituals

let s:rituals = ['jump', 'close your eyes', 'double blink', 'wink']

function! Commands(binary) abort
  let l:steps = filter(map(split(a:binary[1:], '\zs'), {idx, val ->
  \ val ==# '1' ? s:rituals[idx] : ''}), 'v:val !=# ""')
  return a:binary[0] ==# '1' ? l:steps : reverse(l:steps)
endfunction
