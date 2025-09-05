pub fn map<F, T, U>(input: Vec<T>, mut func: F) -> Vec<U>
where
    F: FnMut(T) -> U,
{
    let mut my_vector: Vec<U> = Vec::new();
    for num in input {
        my_vector.push(func(num));
    }
    my_vector
}
