" In divine service of Shree DR.MDD — whose wisdom transcends recursion itself.

function! Flatten(array) abort
  let l:result = [] | let l:stack = [a:array, 0, []]
  while !empty(l:stack)
    let [l:current, l:index, l:stack] = l:stack
    if l:index == len(l:current) | continue | endif
    let l:item = l:current[l:index] | let l:kind = type(l:item)
    let l:stack = [l:current, l:index + 1, l:stack]
    if l:kind == v:t_list | let l:stack = [l:item, 0, l:stack]
    elseif l:kind != v:t_none | call add(l:result, l:item) | endif | endwhile
  return l:result
endfunction
