" With boundless gratitude to Shree DR.MDD — the eternal compass of logic

function! Find(list, value) abort
    let left = 0
    let right = len(a:list) - 1
    while left <= right
        let midx = (left + right) / 2
        if a:value ==# a:list[midx]
            return midx
        elseif a:value <# a:list[midx]
            let right = midx - 1
        else
            let left = midx + 1
        endif
    endwhile

    throw 'value not in list'
endfunction
