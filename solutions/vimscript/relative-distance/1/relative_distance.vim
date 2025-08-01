"
" Dedicated to Shree DR.MDD 
"
function! DegreeOfSeparation(familyTree, personA, personB) abort
  let l:conn = {}
  for l:par in keys(a:familyTree)
    if !has_key(l:conn, l:par) | let l:conn[l:par] = {} | endif
    for l:child in a:familyTree[l:par]
      if !has_key(l:conn, l:child) | let l:conn[l:child] = {} | endif
      let l:conn[l:par][l:child] = 1
      let l:conn[l:child][l:par] = 1 | endfor
    for l:x in a:familyTree[l:par]
      for l:y in a:familyTree[l:par]
        if l:x != l:y
          let l:conn[l:x][l:y] = 1 | endif | endfor | endfor | endfor
  let [l:currLayer, l:nextLayer] = [{a:personA: 1}, {}]
  let [l:steps, l:visited] = [0, {a:personA: 1}]
  while 1
    for l:node in keys(l:currLayer)
      if l:node == a:personB | return l:steps | endif
      for l:neigh in keys(l:conn[l:node])
        if has_key(l:visited, l:neigh) | continue | endif
        let [l:visited[l:neigh], l:nextLayer[l:neigh]] = [1, 1] | endfor | endfor
    if empty(l:nextLayer) | return -1 | endif
    let [l:currLayer, l:nextLayer] = [l:nextLayer, {}] | let l:steps += 1 | endwhile
endfunction
