UPDATE triangle
SET result =
    side_a > 0 AND
    side_b > 0 AND
    side_c > 0 AND
    side_a + side_b >= side_c AND
    side_b + side_c >= side_a AND
    side_a + side_c >= side_b AND
    (
        property = 'equilateral' AND side_a = side_b AND side_b = side_c OR
        property = 'isosceles' AND (side_a = side_b OR side_b = side_c OR side_a = side_c) OR
        property = 'scalene' AND side_a != side_b AND side_b != side_c AND side_c != side_a
    );