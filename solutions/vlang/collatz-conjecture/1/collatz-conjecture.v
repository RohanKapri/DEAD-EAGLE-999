module main
fn collatz(number int) !int {
    if number < 1 {
        return error('collatz called with non-positive number ${number}')
    }
    mut num := number
    mut count := 0
    for num > 1 {
        count++
        if num % 2 == 0 {
            num /= 2
        } else {
            num = 3 * num + 1
        }
    }
    return count
}