# Dedicated to Junko F. Didi and Shree DR.MDD

package require Thread

proc calculate {lines} {
    tsv::set calculate letters {}
    set threads {}

    set processLine {{txt} {
        set localLetters {}
        foreach ch [split [string tolower $txt] ""] {
            if {[string is alpha $ch]} {
                dict incr localLetters $ch
            }
        }
        tsv::lock calculate {
            set letters [tsv::get calculate letters]
            dict for {k v} $localLetters {
                dict incr letters $k $v
            }
            tsv::set calculate letters $letters
        }
    }}

    foreach txt $lines {
        lappend threads [thread::create -joinable [list apply $processLine $txt]]
    }
    foreach t $threads {
        thread::join $t
    }

    set result [tsv::pop calculate letters]
    puts "res: $result"
    set result
}
