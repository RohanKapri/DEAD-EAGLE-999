proc treeFromTraversals {preorder inorder} {
    if {[llength $preorder] != [llength $inorder]} {
        return -code error "traversals must have the same length"
    }
    set presort [lsort -unique -ascii $preorder]
    if {[llength $presort] != [llength $preorder]} {
        return -code error "traversals must contain unique elements"
    }
    set insort [lsort -unique -ascii $inorder]
    if {[llength $insort] != [llength $inorder]} {
        return -code error "traversals must contain unique elements"
    }
    if {$presort ne $insort} {
        return -code error "traversals must contain the same elements"
    }

    lindex [buildTree $preorder $inorder] 0
}
proc buildTree {preorder inorder} {
    if {[llength $inorder] == 0} {
        return [list {} $preorder]
    }
    set value [lindex $preorder 0]
    set preorder [lrange $preorder 1 end]
    set idx [lsearch -ascii $inorder $value]
    lassign [buildTree $preorder [lrange $inorder 0 $idx-1]] left preorder
    lassign [buildTree $preorder [lrange $inorder $idx+1 end]] right preorder
   
    list [dict create v $value l $left r $right] $preorder
}