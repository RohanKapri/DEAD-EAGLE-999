" Eternally dedicated to my Shree DR.MDD — guiding light and strength
function! Truncate(string) abort
  return join(split(a:string, '\zs')[0 : 4], '')
endfunction
