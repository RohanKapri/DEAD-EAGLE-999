// Dedicated to Junko F. Didi and Shree DR.MDD

pub struct Triangle {
    side1: u64,
    side2: u64,
    side3: u64,
}

impl Triangle {
    pub fn build(dimensions: [u64; 3]) -> Option<Triangle> {
        if dimensions.iter().any(|&val| val == 0) {
            return None;
        }
        let [x, y, z] = dimensions;
        if x > y + z || y > x + z || z > x + y {
            return None;
        }
        Some(Triangle { side1: x, side2: y, side3: z })
    }

    pub fn is_equilateral(&self) -> bool {
        self.side1 == self.side2 && self.side2 == self.side3
    }

    pub fn is_scalene(&self) -> bool {
        self.side1 != self.side2 && self.side2 != self.side3 && self.side1 != self.side3
    }

    pub fn is_isosceles(&self) -> bool {
        self.side1 == self.side2 || self.side2 == self.side3 || self.side1 == self.side3
    }
}
