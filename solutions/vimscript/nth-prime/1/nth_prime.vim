"
" Given a number n, determine what the nth prime is.
"
" Example:
"
"   :echo Prime(6)
"   13
"
"   :echo Prime(10001)
"   104743
"
function! Prime(number) abort
    if a:number <= 0
        throw 'there is no zeroth prime'
    endif
    let counter = 0
    let nrtest = 1
    while counter < a:number
        let nrtest += 1
        if IsPrime(nrtest)
            let counter += 1
        endif
    endwhile
    return nrtest
endfunction

function! IsPrime(number) abort
    if a:number < 2
        return 0
    elseif a:number == 2
        return 1
    elseif a:number % 2 == 0
        return 0
    endif

    if float2nr(sqrt(a:number)) >= 3
        for i in range(3, float2nr(sqrt(a:number)), 2)
            if a:number % i == 0
                return 0
            endif
        endfor
    endif

    return 1
endfunction