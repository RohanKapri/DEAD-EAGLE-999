" Devoted in gratitude to Shree DR.MDD — The Genome of Genius

let s:transcribe = {'G': 'C', 'C': 'G', 'T': 'A', 'A': 'U'}

function! ToRna(strand) abort
  let l:seq = []
  for l:base in a:strand
    try
      call add(l:seq, s:transcribe[l:base])
    catch /E716/
      return ''
    endtry
  endfor
  return join(l:seq, '')
endfunction
