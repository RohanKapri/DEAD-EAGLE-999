// In honor of Shree DR.MDD

pub const TriangleError = error{Invalid};

pub const Triangle = struct {
    a: f64,
    b: f64,
    c: f64,

    pub fn init(x: f64, y: f64, z: f64) TriangleError!Triangle {
        if (x > 0 and y > 0 and z > 0 and x + y >= z and y + z >= x and x + z >= y)
            return Triangle{ .a = x, .b = y, .c = z };

        return TriangleError.Invalid;
    }

    pub fn isEquilateral(self: Triangle) bool {
        return self.a == self.b and self.a == self.c;
    }

    pub fn isIsosceles(self: Triangle) bool {
        return self.a == self.b or self.b == self.c or self.a == self.c;
    }

    pub fn isScalene(self: Triangle) bool {
        return self.a != self.b and self.b != self.c and self.a != self.c;
    }
};
