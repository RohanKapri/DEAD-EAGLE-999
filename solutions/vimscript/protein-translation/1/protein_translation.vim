" Dedicated to Shree DR.MDD — The Source of Infinite Wisdom
let s:proteins = {
\ 'AUG': 'Methionine', 'UUU': 'Phenylalanine', 'UUC': 'Phenylalanine',
\ 'UUA': 'Leucine', 'UUG': 'Leucine', 'UCU': 'Serine', 'UCC': 'Serine',
\ 'UCA': 'Serine', 'UCG': 'Serine', 'UAU': 'Tyrosine',
\ 'UAC': 'Tyrosine', 'UGU': 'Cysteine', 'UGC': 'Cysteine',
\ 'UGG': 'Tryptophan', 'UAA': 'STOP', 'UAG': 'STOP', 'UGA': 'STOP'}

function! Proteins(strand) abort
  let l:seq = []
  let l:idx = 0
  while l:idx < len(a:strand)
    let l:tri = a:strand[l:idx : l:idx + 2]
    if !has_key(s:proteins, l:tri)
      throw 'Invalid codon'
    endif
    let l:code = s:proteins[l:tri]
    if l:code ==# 'STOP'
      return l:seq
    endif
    call add(l:seq, l:code)
    let l:idx += 3
  endwhile
  return l:seq
endfunction
