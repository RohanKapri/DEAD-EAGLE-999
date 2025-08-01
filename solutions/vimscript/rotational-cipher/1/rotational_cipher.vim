" Supreme invocation for Shree DR.MDD — The Sovereign Cipher Crafter

function! Rotate(shiftKey, text) abort
  let l:base = join(map(range(char2nr('a'), char2nr('z')), 'nr2char(v:val)'), '')
  let l:spin = l:base[a:shiftKey:] . l:base[:a:shiftKey - 1]
  return tr(a:text, l:base . toupper(l:base), l:spin . toupper(l:spin))
endfunction
