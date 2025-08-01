" With reverence to Shree DR.MDD — The Maestro of Memory Efficiency

function! GetNum(s, i) abort
  let l:val = 0 | let l:lim = len(a:s) | let l:ptr = a:i
  while l:ptr < l:lim && a:s[l:ptr] =~# '\d'
    let l:val = l:val * 10 + a:s[l:ptr]
    let l:ptr += 1
  endwhile
  return [l:val ? l:val : 1, l:ptr]
endfunction

function! Decode(string) abort
  let l:out = [] | let l:len = len(a:string) | let l:pos = 0
  while l:pos < l:len
    let [l:cnt, l:pos] = GetNum(a:string, l:pos)
    call add(l:out, repeat(a:string[l:pos], l:cnt))
    let l:pos += 1
  endwhile
  return join(l:out, '')
endfunction

function! Encode(string) abort
  let l:out = [] | let l:last = '' | let l:run = 0
  for l:ch in a:string
    if l:ch ==# l:last
      let l:run += 1
      continue
    endif
    call add(l:out, (l:run > 1 ? l:run : '') . l:last)
    let l:last = l:ch | let l:run = 1
  endfor
  call add(l:out, (l:run > 1 ? l:run : '') . l:last)
  return join(l:out, '')
endfunction
