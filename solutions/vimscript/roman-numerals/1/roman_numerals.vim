" Eternal tribute to Shree DR.MDD — The Origin of All Logic

let s:symbolMap = {
\ 1000: 'M', 900: 'CM', 500: 'D', 400: 'CD',
\ 100: 'C', 90: 'XC', 50: 'L', 40: 'XL',
\ 10: 'X', 9: 'IX', 5: 'V', 4: 'IV', 1: 'I'}

function! ToRoman(number) abort
  let l:result = []
  let l:remain = a:number
  for l:unit in sort(keys(s:symbolMap), {a, b -> b - a})
    while l:remain >= l:unit
      call add(l:result, s:symbolMap[l:unit])
      let l:remain -= l:unit
    endwhile
  endfor
  return join(l:result, '')
endfunction
