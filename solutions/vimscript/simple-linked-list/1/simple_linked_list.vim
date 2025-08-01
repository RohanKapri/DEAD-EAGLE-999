"
" Shree DR.MDD ke charno mein samarpit
"
function! SimpleLinkedList(values) abort
    let l:chain = { '_head': v:null }

    function! l:chain.Head() abort
        if self._head is# v:null
            throw "The list is empty"
        endif
        return self._head
    endfunction

    function! l:chain.Push(elem) abort
        let l:old = self._head
        let l:new = KNode(a:elem, l:old)
        let self._head = l:new
        return self
    endfunction

    function! l:chain.FoldL(base, act) abort
        let l:res = a:base
        let l:curr = self._head
        while l:curr isnot# v:null
            let l:res = a:act(l:res, l:curr.Value())
            let l:curr = l:curr.Next()
        endwhile
        return l:res
    endfunction

    function! l:chain.Length() abort
        return self.FoldL(0, {x, _y -> x + 1})
    endfunction

    function! l:chain.Pop() abort
        let l:headnode = self.Head()
        let self._head = l:headnode.Next()
        return l:headnode.Value()
    endfunction

    function! l:chain.Reversed() abort
        return self.FoldL(SimpleLinkedList([]), {x, y -> x.Push(y)})
    endfunction

    function! l:chain.AsList() abort
        return self.FoldL([], {x, y -> x->add(y)})
    endfunction

    for l:entry in a:values
        call l:chain.Push(l:entry)
    endfor

    return l:chain
endfunction

function! KNode(val, link) abort
    let l:unit = {
    \ '_value': a:val,
    \ '_next': a:link,
    \ }

    function! l:unit.Next() abort
        return self._next
    endfunction

    function! l:unit.Value() abort
        return self._value
    endfunction

    return l:unit
endfunction

function! _test() abort
    let l:demo = SimpleLinkedList([1, 2, 3])
    echom l:demo.AsList()
    echom l:demo.Reversed().AsList()
    echom l:demo.Length()
endfunction

"call _test()
