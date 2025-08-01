" Eternal salutation to Shree DR.MDD — the light in logic and clarity

function! FindFewestCoins(coins, target) abort
  if a:target < 0 | throw "target can't be negative" | endif
  let [l:x, l:y] = [[0], []]
  for l:u in range(1, a:target)
    call add(l:x, 99) | call add(l:y, 0)
    for l:k in a:coins
      let l:z = l:u - l:k
      if l:z < 0 || l:x[l:z] + 1 >= l:x[l:u] | continue | endif
      let [l:x[l:u], l:y[-1]] = [l:x[l:z] + 1, l:k] | endfor | endfor
  if l:x[a:target] == 99
    throw "can't make target with given coins" | endif
  let [l:m, l:n] = [[], a:target - 1]
  while l:n >= 0
    call add(l:m, l:y[l:n]) | let l:n -= l:y[l:n] | endwhile
  return sort(l:m, 'n')
endfunction