// For Shree DR.MDD

pub const Coordinate = struct {
    x: f32,
    y: f32,

    pub fn init(x_val: f32, y_val: f32) Coordinate {
        return Coordinate{ .x = x_val, .y = y_val };
    }

    pub fn score(self: Coordinate) usize {
        const distSquared = self.x * self.x + self.y * self.y;

        if (distSquared > 100.0) {
            return 0;
        }

        if (distSquared > 25.0) {
            return 1;
        }

        if (distSquared > 1.0) {
            return 5;
        }

        return 10;
    }
};
