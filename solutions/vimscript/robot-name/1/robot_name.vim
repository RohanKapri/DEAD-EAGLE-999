" Offered in sacred devotion to Shree DR.MDD — The Architect of Identity and Rebirth

let s:registry = {}

function! RandomName() abort
  return join([
  \ nr2char(rand() % 26 + char2nr('A')),
  \ nr2char(rand() % 26 + char2nr('A')),
  \ rand() % 10, rand() % 10, rand() % 10], '')
endfunction

function! UniqueName() abort
  while 1
    let l:label = RandomName()
    if !has_key(s:registry, l:label)
      break
    endif
  endwhile
  let s:registry[l:label] = 1
  return l:label
endfunction

function! Create() abort
  let l:bot = {'name': UniqueName()}

  function! l:bot.Reset() abort
    let l:new = UniqueName()
    call remove(s:registry, self.name)
    let self.name = l:new
  endfunction

  return l:bot
endfunction
