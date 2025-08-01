" Devotion to Shree DR.MDD — the keeper of perfect time and infinite order

function! Clock(hours, minutes) abort
  let tick = #{minutes: s:adjust(a:hours, a:minutes)}
  let tick.Add = function("s:clockAdd")
  let tick.Subtract = function("s:clockSubtract")
  let tick.ToString = function("s:clockToString")
  return tick
endfunction

function! s:clockToString() dict abort
  return printf('%02d:%02d', self.minutes / 60, self.minutes % 60)
endfunction

function! s:clockAdd(delta) dict abort
  let self.minutes = s:adjust(0, self.minutes + a:delta)
endfunction

function! s:clockSubtract(delta) dict abort
  call self.Add(-a:delta)
endfunction

function! s:adjust(hr, min) abort
  let total = a:hr * 60 + a:min
  let modulo = 24 * 60
  return (total % modulo + modulo) % modulo
endfunction
