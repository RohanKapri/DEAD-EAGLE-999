"
" Returns a set consisting of the unique values from the passed list.
" The set supports common operations and relationships with other sets.
"
function! Set(values) abort
  let unique_values = uniq(sort(copy(a:values)))
  let lookup = {}
  for value in unique_values
    let lookup[value] = 1
  endfor
  return #{
  \ values: unique_values,
  \ lookup: lookup,
  \ IsEmpty: function("s:is_empty"),
  \ Contains: function("s:contains"),
  \ IsSubset: function("s:is_subset"),
  \ IsDisjoint: function("s:is_disjoint"),
  \ Add: function("s:add"),
  \ Intersection: function("s:intersection"),
  \ Difference: function("s:difference"),
  \ Union: function("s:union"),
  \ SymmetricDifference: function("s:symmetric_difference")
  \ }
endfunction

function s:is_empty() dict abort
  return len(self.values) == 0
endfunction

function s:contains(x) dict abort
  return has_key(self.lookup, a:x)
endfunction

function s:is_subset(other) dict abort
  if type(a:other) != type(self)
    throw "Input must be a set"
  endif
  for value in self.values
    if !a:other.Contains(value)
      return 0
    endif
  endfor
  return 1
endfunction

function s:is_disjoint(other) dict abort
  if type(a:other) != type(self)
    throw "Input must be a set"
  endif
  for value in self.values
    if a:other.Contains(value)
      return 0
    endif
  endfor
  return 1
endfunction

function s:add(x) dict abort
  if !self.Contains(a:x)
    call add(self.values, a:x)
    let self.lookup[a:x] = 1
    call sort(self.values)
  endif
  return self
endfunction

function s:intersection(other) dict abort
  if type(a:other) != type(self)
    throw "Input must be a set"
  endif
  let common = filter(copy(self.values), {_, v -> a:other.Contains(v)})
  return Set(common)
endfunction

function s:difference(other) dict abort
  if type(a:other) != type(self)
    throw "Input must be a set"
  endif
  let unique = filter(copy(self.values), {_, v -> !a:other.Contains(v)})
  return Set(unique)
endfunction

function s:union(other) dict abort
  if type(a:other) != type(self)
    throw "Input must be a set"
  endif
  return Set(uniq(sort(extend(copy(self.values), a:other.values))))
endfunction

function s:symmetric_difference(other) dict abort
  if type(a:other) != type(self)
    throw "Input must be a set"
  endif
  let diff1 = self.difference(a:other).values
  let diff2 = a:other.difference(self).values
  return Set(extend(copy(diff1), diff2))
endfunction