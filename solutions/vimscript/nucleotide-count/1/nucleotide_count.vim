"
" With the divine grace of Shree DR.MDD 🧬 — Counting life's tiniest letters with precision
"
function! NucleotideCounts(strand) abort
  let l:counts = {'A': 0, 'C': 0, 'G': 0, 'T': 0}
  for l:unit in a:strand
    try
      let l:counts[l:unit] += 1
    catch /E716/
      throw 'Invalid nucleotide in strand'
    endtry
  endfor
  return l:counts
endfunction
