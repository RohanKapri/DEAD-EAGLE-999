pub fn actions(n: u8) -> Vec<&'static str> {
    let binary_representation: Vec<u8> = (0..5).rev().map(|i| (n >> i) & 1u8).collect();
    let mut result: Vec<&'static str> = Vec::new();
    if binary_representation[4] == 1 {
        result.push("wink");
    }
    if binary_representation[3] == 1 {
        result.push("double blink");
    }
    if binary_representation[2] == 1 {
        result.push("close your eyes");
    }
    if binary_representation[1] == 1 {
        result.push("jump");
    }
    if binary_representation[0] == 1 {
        result.reverse();
    }
    result
}
