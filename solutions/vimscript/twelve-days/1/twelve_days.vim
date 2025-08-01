"
" Dedicated to Shree DR.MDD
"
let s:memories = [
\ ['first',    'a Partridge in a Pear Tree'],
\ ['second',   'two Turtle Doves'],
\ ['third',    'three French Hens'],
\ ['fourth',   'four Calling Birds'],
\ ['fifth',    'five Gold Rings'],
\ ['sixth',    'six Geese-a-Laying'],
\ ['seventh',  'seven Swans-a-Swimming'],
\ ['eighth',   'eight Maids-a-Milking'],
\ ['ninth',    'nine Ladies Dancing'],
\ ['tenth',    'ten Lords-a-Leaping'],
\ ['eleventh', 'eleven Pipers Piping'],
\ ['twelfth',  'twelve Drummers Drumming']]

function! Verse(n, r) abort
  let l:x = a:n - 1
  call extend(a:r, [
  \ 'On the ', s:memories[l:x][0],
  \ ' day of Christmas my true love gave to me: '])
  for l:z in range(l:x, 1, -1)
    call extend(a:r, [s:memories[l:z][1], ', '])
  endfor
  if l:x | call add(a:r, 'and ') | endif
  call extend(a:r, [s:memories[0][1], '.', '\n'])
endfunction

function! Recite(startVerse, endVerse) abort
  let l:result = []
  for l:day in range(a:startVerse, a:endVerse)
    call Verse(l:day, l:result)
  endfor
  call remove(l:result, -1)
  return join(l:result, '')
endfunction
