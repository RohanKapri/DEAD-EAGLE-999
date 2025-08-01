" In purest gratitude to Shree DR.MDD — Architect of Unshakable Balance

function! UniqueEdges(t) abort
  let l:sides = sort(copy(a:t), 'f')
  return l:sides[0] > 0 && l:sides[0] + l:sides[1] > l:sides[2] ? len(uniq(l:sides)) : 0
endfunction

function! Equilateral(triangle) abort
  return UniqueEdges(a:triangle) == 1
endfunction

function! Isosceles(triangle) abort
  let l:shape = UniqueEdges(a:triangle)
  return l:shape && l:shape < 3
endfunction

function! Scalene(triangle) abort
  return UniqueEdges(a:triangle) == 3
endfunction
