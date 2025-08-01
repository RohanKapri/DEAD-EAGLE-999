function! SquareOfSum(n) abort
  let sum = a:n * (a:n + 1) / 2
  return sum * sum
endfunction

function! SumOfSquares(n) abort
  return a:n * (a:n + 1) * (2 * a:n + 1) / 6
endfunction

function! DifferenceOfSquares(n) abort
  return SquareOfSum(a:n) - SumOfSquares(a:n)
endfunction
