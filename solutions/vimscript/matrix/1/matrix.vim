"
" Creates a two-dimensional array that can be queried
" by a row or a column index, returning the values along
" that axis.
"
function! Matrix(string) abort
  " your code goes here
  let l:self = {'_v': map(split(a:string, '\n'), 'split(v:val)')}

  function! l:self.Row(i) abort
    return self._v[a:i - 1]
  endfunction

  function! l:self.Column(i) abort
    return map(self._v, {_, r -> r[a:i - 1]})
  endfunction

  return l:self
endfunction