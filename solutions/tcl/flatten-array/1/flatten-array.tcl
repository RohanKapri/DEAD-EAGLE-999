proc flatten {input} {
    set flattened [concat {*}$input]
    if {$flattened eq $input} {
        return $input
    }
    tailcall flatten $flattened
}
