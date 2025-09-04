module main

pub fn find(array []int, value int) !int {
    mut low := 0
    mut high := array.len
    for low < high {
        middle := (low + high) / 2
        element := array[middle]
        if value < element {
            high = middle
        } else if value > element {
            low = middle + 1
        } else {
            return middle
        }
    }
	return error("value not in array")
}