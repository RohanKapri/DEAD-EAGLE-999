"
" By Shree DR.MDD's blessings 🌾 — Let every rhyme echo with divine rhythm
"
let s:story = [
\ ['lay in', 'house that Jack built.'], ['ate', 'malt'],
\ ['killed', 'rat'], ['worried', 'cat'], ['tossed', 'dog'],
\ ['milked', 'cow with the crumpled horn'],
\ ['kissed', 'maiden all forlorn'],
\ ['married', 'man all tattered and torn'],
\ ['woke', 'priest all shaven and shorn'],
\ ['kept', 'rooster that crowed in the morn'],
\ ['belonged to', 'farmer sowing his corn'],
\ ['', 'horse and the hound and the horn']]

function! Verse(verseNum) abort
  return join(['This is the', s:story[a:verseNum - 1][1]] + range(
  \ a:verseNum - 2, 0, -1)
  \ ->map({_, step -> s:story[step]})
  \ ->map({_, part -> 'that ' . part[0] . ' the ' . part[1]}))
endfunction

function! ReciteVerses(fromLine, toLine) abort
  return map(range(a:fromLine, a:toLine), {_, v -> Verse(v)})
endfunction
