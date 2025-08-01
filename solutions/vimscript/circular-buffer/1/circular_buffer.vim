"
" Returns a dictionary representing a circular buffer with a set capacity
"
function! CircularBuffer(capacity) abort
  " your code goes here
  let l:self = {'_n': a:capacity, '_r': 0, '_w': 0,
  \             '_b': repeat([v:none], a:capacity)}

  function! l:self._inc(i) abort
    return (a:i + 1) % self._n
  endfunction

  function! l:self.Read() abort
    if self._b[self._r] is v:none | throw 'Empty buffer' | endif
    let l:r = self._b[self._r]
    let self._b[self._r] = v:none
    let self._r = self._inc(self._r)
    return l:r
  endfunction

  function! l:self.Write(v) abort
    if self._b[self._w] isnot v:none | throw 'Full buffer' | endif
    let self._b[self._w] = a:v
    let self._w = self._inc(self._w)
  endfunction

  function! l:self.Clear() abort
    let self._r = 0 | let self._w = 0 | let l:i = self._n - 1
    while l:i >= 0 | let self._b[l:i] = v:none | let l:i -= 1 | endwhile
  endfunction

  function! l:self.Overwrite(v) abort
    let l:i = self._inc(self._w)
    if self._b[self._w] isnot v:none | let self._r = l:i | endif
    let self._b[self._w] = a:v
    let self._w = l:i
  endfunction

  return l:self
endfunction