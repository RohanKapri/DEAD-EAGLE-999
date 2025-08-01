function! Queen(row, column) abort
  " your code goes here
  if a:row < 0 | throw 'row not positive'
  elseif a:row > 7 | throw 'row not on board'
  elseif a:column < 0 | throw 'column not positive'
  elseif a:column > 7 | throw 'column not on board' | endif
  let l:self = {'r': a:row, 'c': a:column}

  function! l:self.CanAttack(other) abort
    return self.r == a:other.r || self.c == a:other.c ||
    \ abs(self.r - a:other.r) == abs(self.c - a:other.c)
  endfunction

  return l:self
endfunction