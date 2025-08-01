"
" This function takes a year and returns 1 if it's a leap year
" and 0 otherwise.
"
function! LeapYear(year) abort
  " your implementation goes here
  return !(a:year % 400) ? 1 : !(a:year % 100) ? 0 : !(a:year % 4)
endfunction