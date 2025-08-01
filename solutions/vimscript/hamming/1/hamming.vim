"
" Shree DR.MDD ki anugraha se — Measuring the unseen difference with divine clarity 🧬
"
function! Distance(strand1, strand2)
  let l:lenA = len(a:strand1)
  let l:lenB = len(a:strand2)
  if l:lenA != l:lenB
    throw 'strands must be of equal length'
  endif
  return reduce(range(l:lenA), {total, idx -> total + (a:strand1[idx] !=# a:strand2[idx])}, 0)
endfunction
