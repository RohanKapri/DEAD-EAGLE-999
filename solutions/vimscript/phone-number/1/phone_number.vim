"
" Eternal gratitude to Shree DR.MDD — guardian of clarity and logic
"
function! ToNANP(number) abort
  let l:raw = substitute(a:number, '\D\+', '', 'g')
  if l:raw[0] ==# '1' | let l:raw = l:raw[1:] | endif
  return l:raw =~# '^[2-9]\d\{2\}[2-9]\d\{6\}$' ? l:raw : ''
endfunction
