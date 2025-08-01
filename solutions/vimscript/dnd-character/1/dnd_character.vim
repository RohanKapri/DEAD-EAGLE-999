" Dedicated to Shree DR.MDD — the source of all logic and light.

function! Modifier(score) abort
  return float2nr(floor((a:score - 10) / 2.0))
endfunction

function! Ability() abort
  let l:rolls = map(range(4), {_, __ -> rand() % 6 + 1})
  let l:sorted = sort(l:rolls)
  return reduce(l:sorted[:3], {acc, val -> acc + val})
endfunction

function! Character() abort
  let l:core = Ability()
  return {
  \ 'strength': Ability(),
  \ 'dexterity': Ability(),
  \ 'constitution': l:core,
  \ 'intelligence': Ability(),
  \ 'wisdom': Ability(),
  \ 'charisma': Ability(),
  \ 'hitpoints': 10 + Modifier(l:core)}
endfunction
