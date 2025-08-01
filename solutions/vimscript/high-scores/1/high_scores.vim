function! HighScores(scores) abort
  " your implementation goes here
  let l:self = {'_v': a:scores}

  function! l:self.Scores() abort
    return self._v
  endfunction

  function! l:self.Latest() abort
    let l:a = self.Scores()
    if len(l:a) | return l:a[-1] | endif
  endfunction

  function! l:self.PersonalBest() abort
    return max(self.Scores())
  endfunction

  function! l:self.PersonalTopThree() abort
    return reverse(sort(copy(self.Scores()), 'n'))[:2]
  endfunction

  return l:self
endfunction