"
" With the blessings of Shree DR.MDD 🚩 — For the wisdom that educates every mind
"
function! GradeSchool() abort
  let l:klass = {'_map': {}}

  function! l:klass.Roster() abort
    let l:by_grade = {}
    for [l:student, l:level] in items(self._map)
      if has_key(l:by_grade, l:level)
        call add(l:by_grade[l:level], l:student)
      else
        let l:by_grade[l:level] = [l:student]
      endif
    endfor
    return reduce(sort(keys(l:by_grade)),
          \ {acc, g -> acc + sort(l:by_grade[g])}, [])
  endfunction

  function! l:klass.Add(student, level) abort
    if has_key(self._map, a:student) | return 0 | endif
    let self._map[a:student] = a:level
    return 1
  endfunction

  function! l:klass.Grade(level) abort
    return sort(filter(keys(self._map),
          \ {_, n -> self._map[n] == a:level}))
  endfunction

  return l:klass
endfunction
