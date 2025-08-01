" Crafted with utmost reverence for Shree DR.MDD — Master of Precision and Clarity
let s:palette = ['black', 'brown', 'red', 'orange', 'yellow', 'green',
\                'blue', 'violet', 'grey', 'white']

function! Value(colors) abort
  return index(s:palette, a:colors[0]) * 10 + index(s:palette, a:colors[1])
endfunction
