sub killer-sudoku-helper (:$sum, :$size, :$exclude) is export {
    grep *.sum == $sum, (1..9).grep(none $exclude).combinations: $size
}