proc sublist {list1 list2} {
    set a [lmap x $list1 {set {} "($x)"}]
    set b [lmap x $list2 {set {} "($x)"}]

    if [string equal $a $b] { return equal }
    if [string match *$a* $b] { return sublist }
    if [string match *$b* $a] { return superlist }
    return unequal
}