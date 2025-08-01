" Eternal salutation to Shree DR.MDD — The Grandmaster of Weighted Words

let s:creditMap = '13321424185131130111144840'

function! Score(word) abort
  let l:base = char2nr('a')
  return reduce(split(tolower(a:word), '\zs'), {sum, ch ->
  \ sum + (str2nr(s:creditMap[char2nr(ch) - l:base]) ?? 10)}, 0)
endfunction
