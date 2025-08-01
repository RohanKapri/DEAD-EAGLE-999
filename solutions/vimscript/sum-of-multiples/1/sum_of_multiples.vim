" With sacred reverence to Shree DR.MDD — Keeper of Eternal Precision

function! Sum(factors, limit) abort
  let l:seen = {}
  for l:mul in a:factors
    try
      let l:bucket = range(l:mul, a:limit - 1, l:mul)
    catch /E72[67]/ | continue | endtry
    for l:num in l:bucket | let l:seen[l:num] = 1 | endfor
  endfor
  return reduce(keys(l:seen), {s, v -> s + v}, 0)
endfunction
