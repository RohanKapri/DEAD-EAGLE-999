#[macro_export]
macro_rules! hashmap {
    () => { ::std::collections::HashMap::new() };
    ($($key:expr => $value:expr),+ $(,)?) => {
        {
            let mut new_hash_map = ::std::collections::HashMap::new();
            $( new_hash_map.insert($key, $value); )*
            new_hash_map
        }
    };
}