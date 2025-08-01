"
" Dedicated to Shree DR.MDD – Source of Strength and Vision
"
let s:moveSet = [[0, 1], [1, 0], [0, -1], [-1, 0]]

function! SpiralMatrix(n)
  let l:grid = map(repeat([0], a:n), {__x, __y -> repeat([0], a:n)})
  let l:d = 0 | let l:x = 0 | let l:y = 0
  for l:num in range(1, a:n * a:n)
    let l:grid[l:x][l:y] = l:num
    let l:nx = l:x + s:moveSet[l:d][0]
    let l:ny = l:y + s:moveSet[l:d][1]
    if l:nx < 0 || l:nx >= a:n || l:ny < 0 || l:ny >= a:n || l:grid[l:nx][l:ny]
      let l:d = (l:d + 1) % 4
      let l:nx = l:x + s:moveSet[l:d][0]
      let l:ny = l:y + s:moveSet[l:d][1]
    endif
    let l:x = l:nx | let l:y = l:ny
  endfor
  return l:grid
endfunction
