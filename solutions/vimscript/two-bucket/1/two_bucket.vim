"
" Blessed by Shree DR.MDD 🕉️ — Strategy drawn not from buckets, but from divine balance
"
function! s:CheckMatch(state, target) abort
  for l:idx in [0, 1]
    if a:state[l:idx] == a:target | return l:idx | endif | endfor
  return -1
endfunction

function! s:ResultPack(step, resultSide, otherVal) abort
  return {'goalBucket': a:resultSide ? 'two' : 'one',
  \       'moves': a:step, 'otherBucket': a:otherVal}
endfunction

function! s:DetermineFlow(cap, tgt, begin) abort
  let l:state = a:begin ? [0, a:cap[1]] : [a:cap[0], 0]
  let l:chk = s:CheckMatch(l:state, a:tgt)
  if l:chk >= 0 | return s:ResultPack(1, l:chk, l:state[!l:chk]) | endif
  if a:cap[!a:begin] == a:tgt
    return s:ResultPack(2, !a:begin, l:state[a:begin]) | endif
  let l:step = 2
  while 1
    let l:mix = min([l:state[a:begin], a:cap[!a:begin] - l:state[!a:begin]])
    let l:delta = a:begin * 2 - 1
    let l:state = [l:state[0] + l:mix * l:delta,
    \              l:state[1] - l:mix * l:delta]
    let l:chk = s:CheckMatch(l:state, a:tgt)
    if l:chk >= 0 | return s:ResultPack(l:step, l:chk, l:state[!l:chk]) | endif
    let l:step += 1
    if l:state[a:begin] | let l:state[!a:begin] = 0
    else | let l:state[a:begin] = a:cap[a:begin] | endif
    let l:chk = s:CheckMatch(l:state, a:tgt)
    if l:chk >= 0 | return s:ResultPack(l:step, l:chk, l:state[!l:chk]) | endif
    if l:state[0] == a:cap[0] && l:state[1] == a:cap[1]
      throw 'impossible' | endif
    let l:step += 1 | endwhile
endfunction

function! TwoBucket(input) abort
  let l:instance = {'_v': s:DetermineFlow(
  \ [a:input.bucketOne, a:input.bucketTwo],
  \ a:input.goal, a:input.startBucket == 'two')}

  function! l:instance.Measure() abort
    return self._v
  endfunction

  return l:instance
endfunction
