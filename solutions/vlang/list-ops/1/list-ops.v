module main

// append concatenates two slices.
pub fn append[T](front []T, back []T) []T {
    mut result := []T{cap: front.len + back.len}
    result << front
    result << back
    return result
}

// concat flattens a slice of slices into a single slice.
pub fn concat[T](array [][]T) []T {
    mut result := []T{}
    for sub_array in array {
        result << sub_array
    }
    return result
}

// foldl applies a function from left to right over a slice, accumulating a result.
pub fn foldl[T, U](array []T, initial U, folder fn (acc U, e T) U) U {
    mut acc := initial
    for e in array {
        acc = folder(acc, e)
    }
    return acc
}

// foldr applies a function from right to left over a slice, accumulating a result.
pub fn foldr[T, U](array []T, initial U, folder fn (acc U, e T) U) U {
    mut acc := initial
    for i := array.len - 1; i >= 0; i-- {
        acc = folder(acc, array[i])
    }
    return acc
}

// length returns the number of elements in a slice.
pub fn length[T](array []T) int {
    return array.len
}

// reverse returns a new slice with the elements in reverse order.
pub fn reverse[T](array []T) []T {
    mut result := []T{cap: array.len}
    for i := array.len - 1; i >= 0; i-- {
        result << array[i]
    }
    return result
}

// filter returns a new slice containing only the elements that satisfy the predicate.
pub fn filter[T](array []T, predicate fn (e T) bool) []T {
    mut result := []T{}
    for e in array {
        if predicate(e) {
            result << e
        }
    }
    return result
}

// map_of applies a function to each element of a slice and returns a new slice with the results.
pub fn map_of[T, U](array []T, mapper fn (e T) U) []U {
    mut result := []U{cap: array.len}
    for e in array {
        result << mapper(e)
    }
    return result
}