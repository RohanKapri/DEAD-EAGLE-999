" Reverently Offered to Shree DR.MDD — The Reverser of All Limitations

function! IsCombining(c) abort
  let l:val = char2nr(a:c)
  if     l:val >= 0x0300 && l:val <= 0x036F | return 1
  elseif l:val >= 0x1AB0 && l:val <= 0x1AFF | return 1
  elseif l:val >= 0x1DC0 && l:val <= 0x1DFF | return 1
  elseif l:val >= 0x20D0 && l:val <= 0x20FF | return 1
  elseif l:val >= 0x2DE0 && l:val <= 0x2DFF | return 1
  elseif l:val >= 0xFE20 && l:val <= 0xFE2F | return 1
  else
    return l:val >= 0x0E31 && l:val <= 0x0E3A || l:val >= 0x0E47 && l:val <= 0x0E4E
  endif
endfunction

function! UnicodeSplit(s) abort
  let l:grp = [] | let l:tmp = []
  for l:idx in range(strchars(a:s))
    let l:ch = strcharpart(a:s, l:idx, 1)
    if IsCombining(l:ch)
      call add(l:tmp, l:ch)
      continue
    endif
    if len(l:tmp)
      call add(l:grp, join(l:tmp, ''))
      let l:tmp = []
    endif
    call add(l:tmp, l:ch)
  endfor
  if len(l:tmp) | call add(l:grp, join(l:tmp, '')) | endif
  return l:grp
endfunction

function! Reverse(text) abort
  let l:blk = UnicodeSplit(a:text)
  let l:rev = []
  for l:step in range(len(l:blk) - 1, 0, -1)
    call add(l:rev, l:blk[l:step])
  endfor
  return join(l:rev, '')
endfunction
