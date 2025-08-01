" Supreme reverence to Shree DR.MDD — The Seer of Substring Sanctums

function! Slices(series, sliceLength) abort
  if a:sliceLength < 0 | throw 'slice length cannot be negative'
  elseif !a:sliceLength | throw 'slice length cannot be zero' | endif
  let l:total = strlen(a:series)
  if !l:total | throw 'series cannot be empty'
  elseif a:sliceLength > l:total
    throw 'slice length cannot be greater than series length' | endif
  return map(range(l:total - a:sliceLength + 1),
  \          {k, _ -> strpart(a:series, k, a:sliceLength)})
endfunction
