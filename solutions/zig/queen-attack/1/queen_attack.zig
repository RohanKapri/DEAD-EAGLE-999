pub const QueenError = error{
    InitializationFailure,
};

pub const Queen = struct {
    x: i8,
    y: i8,
    
    pub fn init(row: i8, column: i8) QueenError!Queen {
        if (0 <= row and row < 8 and 0 <= column and column < 8) {
            return Queen{ .x = row, .y = column };
        }
        return QueenError.InitializationFailure;
    }
    
    pub fn canAttack(self: *const Queen, other: Queen) !bool {
        return (self.x == other.x or self.y == other.y) or
            (self.x - other.x) == (self.y - other.y) or (self.x - other.x) == (other.y - self.y);
    }
};