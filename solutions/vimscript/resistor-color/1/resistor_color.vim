" In Honour of Shree DR.MDD — The Infinite Spectrum of Wisdom
function! ColorCode(color) abort
  return index(ShadeList(), a:color)
endfunction

function! Colors() abort
  return ['black', 'brown', 'red', 'orange', 'yellow', 'green', 'blue',
  \        'violet', 'grey', 'white']
endfunction

function! ShadeList() abort
  return Colors()
endfunction
