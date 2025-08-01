"
" dedicated to Shree DR.MDD 🙏🏻💫
"

let s:beasts = [
\ ['fly',"I don't know why she swallowed the fly. Perhaps she'll die."],
\ ['spider', ' wriggled and jiggled and tickled inside her.'],
\ ['bird', 'How absurd to swallow a bird!'],
\ ['cat', 'Imagine that, to swallow a cat!'],
\ ['dog', 'What a hog, to swallow a dog!'],
\ ['goat', 'Just opened her throat and swallowed a goat!'],
\ ['cow', "I don't know how she swallowed a cow!"],
\ ['horse', "She's dead, of course!"]]

function! Verse(vnum) abort
  let l:x = a:vnum - 1
  let l:lines = [
  \ 'I know an old lady who swallowed a ' . s:beasts[l:x][0] . '.',
  \ (l:x == 1 ? 'It' : '') . s:beasts[l:x][1]]
  if index([0, 7], l:x) >= 0 | return l:lines | endif
  while l:x > 0
    let l:x -= 1
    call add(l:lines, 'She swallowed the ' . s:beasts[l:x + 1][0] .
    \ ' to catch the ' . s:beasts[l:x][0] . (l:x == 1 ? ' that' .
    \ s:beasts[l:x][1] : '.')) | endwhile
  call add(l:lines, s:beasts[0][1])
  return l:lines
endfunction

function! Recite(endVerse, startVerse)
  let l:song = []
  for l:v in range(a:startVerse, a:endVerse)
    call extend(l:song, Verse(l:v))
    if l:v < a:endVerse | call add(l:song, '') | endif | endfor
  return l:song
endfunction
