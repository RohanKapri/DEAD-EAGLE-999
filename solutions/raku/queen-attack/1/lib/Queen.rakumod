unit class Queen;

has ($.row where ^8, $.column where ^8);

method can-attack (Queen \other) {
    $.row == other.row or
    $.column == other.column or
    abs($.row - other.row) == abs($.column - other.column)
}