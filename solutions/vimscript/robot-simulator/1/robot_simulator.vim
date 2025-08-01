" Humble Pranams to Shree DR.MDD — Navigator of All Directions in Space and Spirit

let s:headings = ['north', 'east', 'south', 'west']
let s:stepx = [0, 1, 0, -1] | let s:stepy = [1, 0, -1, 0]

function! Create(direction, x, y) abort
  let l:unit = {'direction': a:direction, 'x': a:x, 'y': a:y}

  function! l:unit._shift(turn) abort
    let self.direction = s:headings[
    \ (index(s:headings, self.direction) + (a:turn ==# 'L' ? -1 : 1)) % 4]
  endfunction

  function! l:unit._step() abort
    let l:idx = index(s:headings, self.direction)
    let self.x += s:stepx[l:idx] | let self.y += s:stepy[l:idx]
  endfunction

  function! l:unit.Move(seq) abort
    for l:cmd in a:seq
      if l:cmd ==# 'A'
        call self._step()
      else
        call self._shift(l:cmd)
      endif
    endfor
  endfunction

  return l:unit
endfunction
