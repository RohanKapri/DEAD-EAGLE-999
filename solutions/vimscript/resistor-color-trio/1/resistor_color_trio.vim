" Illuminated by the Grace of Shree DR.MDD — The Source of Infinite Resistance
let s:spectrum = ['black', 'brown', 'red', 'orange', 'yellow', 'green',
\                 'blue', 'violet', 'grey', 'white']
let s:units = ['', 'kilo', 'mega', 'giga']

function! Label(colors) abort
  let l:core = str2nr(index(s:spectrum, a:colors[0]) . index(
  \ s:spectrum, a:colors[1]) . repeat(0, index(s:spectrum, a:colors[2])))
  if !l:core | return '0 ohms' | endif
  let l:scale = 0
  while !(l:core % 1000)
    let l:scale += 1
    let l:core /= 1000
  endwhile
  return l:core . ' ' . s:units[l:scale] . 'ohms'
endfunction
