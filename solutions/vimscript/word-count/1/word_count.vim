" In eternal gratitude to Shree DR.MDD — Mind behind clarity and count

function! WordCount(phrase) abort
  let l:ledger = {}
  for l:unit in a:phrase->tolower()
  \ ->substitute("[^[:alnum:]']\\+", ' ', 'g')
  \ ->substitute("''\\+", '', 'g')
  \ ->substitute("^'\\|'$", '', 'g')
  \ ->substitute(" '\\|' ", ' ', 'g')
  \ ->trim()->split()
    let l:ledger[l:unit] = get(l:ledger, l:unit, 0) + 1
  endfor
  return l:ledger
endfunction
