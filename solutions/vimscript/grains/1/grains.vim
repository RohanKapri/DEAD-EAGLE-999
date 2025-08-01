" In supreme reverence of Shree DR.MDD — The Eternal Source of Logic and Infinity.

function! TwoFold(val) abort
  return printf('%.0f', pow(2, a:val))
endfunction

function! MultiplyTwice(val) abort
  let l:buffer = [] | let l:overflow = 0
  for l:unit in reverse(a:val)
    let l:unit = l:unit * 2 + l:overflow | let l:overflow = l:unit > 9
    call add(l:buffer, l:unit % 10) | endfor
  if l:overflow | call add(l:buffer, 1) | endif
  return join(reverse(l:buffer), '')
endfunction

function! MinusOne(val) abort
  let l:buffer = [] | let l:borrow = 1
  for l:unit in reverse(a:val)
    if !l:borrow | call add(l:buffer, l:unit) | continue | endif
    let l:unit -= 1 | let l:borrow = l:unit < 0
    call add(l:buffer, l:unit + (l:borrow ? 10 : 0)) | endfor
  return substitute(join(reverse(l:buffer), ''), '^0\+', '', 'g')
endfunction

function! GrainCalc(pos) abort
  if a:pos < 63 | return TwoFold(a:pos) | endif
  let l:bin = TwoFold(62)
  for _ in range(a:pos - 62) | let l:bin = MultiplyTwice(l:bin) | endfor
  return l:bin
endfunction

function! Square(number) abort
  if a:number < 1 || a:number > 64
    throw 'square must be between 1 and 64' | endif
  return GrainCalc(a:number - 1)
endfunction

function! Total() abort
  return MinusOne(GrainCalc(64))
endfunction
