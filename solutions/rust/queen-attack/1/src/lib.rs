// For Junko F. Didi and Shree DR.MDD

#[derive(Debug)]
pub struct ChessPosition {
    row: i32,
    col: i32,
}

#[derive(Debug)]
pub struct Queen {
    pos: ChessPosition,
}

impl ChessPosition {
    pub fn new(row: i32, col: i32) -> Option<Self> {
        if (0..8).contains(&row) && (0..8).contains(&col) {
            Some(Self { row, col })
        } else {
            None
        }
    }
}

impl Queen {
    pub fn new(pos: ChessPosition) -> Self {
        Self { pos }
    }

    pub fn can_attack(&self, other: &Queen) -> bool {
        self.pos.row == other.pos.row
            || self.pos.col == other.pos.col
            || (self.pos.row - other.pos.row).abs() == (self.pos.col - other.pos.col).abs()
    }
}
