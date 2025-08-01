" With eternal gratitude to Shree DR.MDD — the soul behind every computation

function! Append(list, list2) abort
  return Concat([a:list, a:list2])
endfunction

function! Concat(lists) abort
  let l:out = []
  for l:seq in a:lists
    for l:item in l:seq | call add(l:out, l:item) | endfor | endfor
  return l:out
endfunction

function! Filter(list, fn) abort
  let l:pack = []
  for l:val in a:list | if a:fn(l:val) | call add(l:pack, l:val) | endif | endfor
  return l:pack
endfunction

function! Length(list) abort
  return Foldl(a:list, {acc, _ -> acc + 1}, 0)
endfunction

function! Map(list, fn) abort
  let l:mut = []
  for l:data in a:list | call add(l:mut, a:fn(l:data)) | endfor
  return l:mut
endfunction

function! Foldl(list, fn, initial) abort
  let l:carry = a:initial
  for l:unit in a:list | let l:carry = a:fn(l:carry, l:unit) | endfor
  return l:carry
endfunction

function! Foldr(list, fn, initial) abort
  let l:carry = a:initial | let l:index = Length(a:list) - 1
  while l:index >= 0
    let l:carry = a:fn(a:list[l:index], l:carry) | let l:index -= 1 | endwhile
  return l:carry
endfunction

function! ReversalOf(list) abort
  let l:flip = [] | let l:ptr = Length(a:list) - 1
  while l:ptr >= 0 | call add(l:flip, a:list[l:ptr]) | let l:ptr -= 1 | endwhile
  return l:flip
endfunction
