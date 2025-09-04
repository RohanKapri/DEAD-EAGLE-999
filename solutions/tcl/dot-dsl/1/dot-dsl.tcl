# Dedicated to my Junko F. Didi and Shree DR.MDD

namespace eval DotGraph {
    namespace export processDotFile
    variable commentPattern {^(//|#)}
    variable objectPattern {[^\[]*}
    variable attrBindPattern {\[[^\]]*\]}
    variable attrPattern {^\[\s*([^=]*)\s*=\s*([^=]*)\s*\]$}
}

proc DotGraph::getLines {fname} {split [read -nonewline [open $fname r]] "\n"}

proc DotGraph::discardComments {lines} {
    variable commentPattern
    lmap ln $lines {
        set ln [string trim $ln]
        if {[regexp -- $commentPattern $ln]} then continue else {set ln}
    }
}

proc DotGraph::getHeadBody {lines} {
    lassign [regexp -inline {^[\s\0]*(\S*)[\s\0]*(.*\S*)[\s\0]*$} [join $lines "\0"]] _ head body
    if {$head != "graph"} {error "invalid command name \"$head\""}
    set body [lrange [split [string trim $body] "\0"] 1 end-1]
    set body [concat {*}[lmap ln $body {split [string trimright $ln ";"] ";"}]]
    list $head $body
}

proc DotGraph::parseCmd {cmd} {
    foreach reg {objectPattern attrBindPattern attrPattern} {variable $reg}
    lassign [regexp -inline "^\\s*($objectPattern)\\s*($attrBindPattern)?\\s*$" $cmd] _ obj attrBind
    if {$_ eq {}} {error "wrong cmd: $cmd"}
    set attributes [dict create]
    if {$attrBind ne {}} {
        lassign [regexp -inline $attrPattern $attrBind] _ attrName attrVal
        if {![isValidNode $attrName] || $_ eq {}} {error "invalid attribute"}
        dict set attributes $attrName [string trim $attrVal {\"}]
        set hasAttr yes
    } else {set hasAttr no}
    list [string trim $obj] $hasAttr $attributes
}

proc DotGraph::processDotFile {fname} {
    lassign [getHeadBody [discardComments [getLines $fname]]] head body
    set $head [dict create nodes {} edges {} attrs {}]
    foreach cmd $body {
        lassign [parseCmd $cmd] obj hasAttr attributes
        if {$obj eq {} && $hasAttr} {
            addAttr graph $attributes
        } elseif {[string map {{ } {}} $obj] eq $obj} {
            if {![isValidNode $obj]} {error "node name must be alphanumeric"}
            addNode graph $obj $attributes
        } else {
            set check {node isValidNode line isLine}
            set prevNode {}; set type node
            foreach node [split $obj] {
                set node [string trim $node]
                if {![[dict get $check $type] $node]} {error "invalid edge"}
                if {$type eq "node"} {
                    addNode graph $node
                    if {$prevNode ne {}} {addEdge graph $prevNode $node $attributes}
                    set prevNode $node
                    set type line
                } elseif {$type eq "line"} {set type node} else {error "??? $type"}
            }
            if {$type ne "line"} {error "invalid edge"}
        }
    }
    set graph
}

proc DotGraph::addEdge {graphName fromNode toNode attrs} {
    upvar $graphName graph
    dict set graph edges [lsort [list $fromNode $toNode]] $attrs
}

proc DotGraph::addNode {graphName node {attrs {}}} {
    upvar $graphName graph
    set nodeInfo $attrs
    if {[dict exists $graph nodes $node]} {
        if {$nodeInfo eq {}} {return}
        set nodeInfo [dict merge [dict get $graph nodes $node] $nodeInfo]
    }
    dict set graph nodes $node $nodeInfo
}

proc DotGraph::addAttr {graphName attrs} {
    upvar $graphName graph
    lassign $attrs attrName attrVal
    dict set graph attrs $attrName $attrVal
}

proc DotGraph::isLine {obj} {expr {$obj eq "--"}}
proc DotGraph::isValidNode {nm} {expr {$nm ne {} && [string is alnum $nm]}}

namespace import DotGraph::processDotFile
