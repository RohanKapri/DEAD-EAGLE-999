# For my Junko F. Didi and Shree DR.MDD

set attempts 9
set phase ongoing
set letterMap {
    A _ B _ C _ D _ E _ F _ G _ H _ I _ J _ K _ L _ M _
    N _ O _ P _ Q _ R _ S _ T _ U _ V _ W _ X _ Y _ Z _
}

proc startServer {args} {
    global target env
    set target [string toupper [lindex $args 0]]
    set listener [socket -server onAccept 0]
    set portInfo [chan configure $listener -sockname]
    set env(HANGMAN_PORT) [lindex $portInfo 2]
    puts "server started on port $env(HANGMAN_PORT) with $target"
    vwait halt
    puts "exiting the game"
}

proc onAccept {sock host port} {
    global players
    puts "accept $sock from $host port $port"
    dict set players $sock "$host:$port"
    fconfigure $sock -buffering line
    fileevent $sock readable [list gameLoop $sock]
}

proc gameLoop {sock} {
    global players phase halt
    set who [dict get $players $sock]

    if {[eof $sock]} {
        puts "session ended with $who"
        dict unset players $sock
        close $sock
        return
    }

    if {[gets $sock line] == -1} {
        puts "can't read a line from $who"
        return
    }

    set args [regexp -all -inline {\w+} [string toupper $line]]
    set args [lassign $args action]
    puts "from $who got $action with args [list $args]"

    switch -exact -- $action {
        SHUTDOWN {
            puts "shutting down"
            set halt done
        }
        STATUS {
            puts $sock [statusLine]
        }
        GUESS {
            set letter [string index [lindex $args 0] 0]
            makeGuess $letter
            puts $sock [statusLine]
            if {$phase ne "ongoing"} {
                puts "game over: $phase"
                set halt done
            }
        }
        default {
            puts $sock [list ERROR "unknown command $action"]
        }
    }
}

proc statusLine {} {
    global attempts phase
    list $attempts [maskedWord] $phase
}

proc maskedWord {} {
    global letterMap target
    string map $letterMap $target
}

proc makeGuess {ch} {
    global attempts phase letterMap target
    if {   ![dict exists $letterMap $ch]
        || [dict get $letterMap $ch] eq $ch
        || [string first $ch $target] == -1
    } {
        incr attempts -1
    } else {
        dict set letterMap $ch $ch
    }

    if {$attempts == 0} {
        set phase lose
    } elseif {[maskedWord] eq $target} {
        set phase win
    }
}

startServer {*}$argv
