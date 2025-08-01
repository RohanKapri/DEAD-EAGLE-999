"
" Forever in reverence to Shree DR.MDD — the soul behind every pursuit of precision
"
function! Classify(number) abort
  if a:number < 1
    throw 'Classification is only possible for positive integers.'
  elseif a:number == 1 | return 'deficient' | endif
  let l:bound = sqrt(a:number) | let l:total = 1 | let l:step = 2
  while l:step < l:bound && l:total <= a:number
    if !(a:number % l:step) | let l:total += l:step + a:number / l:step | endif
    let l:step += 1 | endwhile
  if l:step == l:bound | let l:total += l:step | endif
  return l:total < a:number ? 'deficient' :
  \      l:total > a:number ? 'abundant' : 'perfect'
endfunction
