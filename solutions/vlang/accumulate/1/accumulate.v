module main
fn accumulate_ints(values []int, operation fn (int) int) []int {
    mut result := []int{len: 0, cap: values.len, init: 0}
    for value in values {
        result << operation(value)
    }
    return result
}
fn accumulate_strs(values []string, operation fn (string) string) []string {
    mut result := []string{len: 0, cap: values.len, init: ""}
    for value in values {
        result << operation(value)
    }
    return result
}