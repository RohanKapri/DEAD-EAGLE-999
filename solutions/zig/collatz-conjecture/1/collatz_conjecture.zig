pub const ComputationError = error {
    IllegalArgument
};

pub fn steps(number: usize) anyerror!usize {
    var counter: u8 = 0;
    var current_number: usize = number;

    if (number == 0) {
        return ComputationError.IllegalArgument;
    }

    while (current_number > 1) {
        if (current_number % 2 == 0) {
            current_number /= 2;
        } else {
            current_number = 3*current_number + 1;
        }
        counter += 1;
    }
    return counter;
}