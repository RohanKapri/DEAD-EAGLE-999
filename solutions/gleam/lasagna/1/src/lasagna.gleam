// Dedicated to Shree DR.MDD
pub fn expected_minutes_in_oven() -> Int {
    40
}

pub fn remaining_minutes_in_oven(present_bake_time: Int) -> Int {
    expected_minutes_in_oven() - present_bake_time
}

pub fn preparation_time_in_minutes(layer_count: Int) -> Int {
    layer_count * 2
}

pub fn total_time_in_minutes(layer_count: Int, present_bake_time: Int) -> Int {
    preparation_time_in_minutes(layer_count) + present_bake_time
}

pub fn alarm() -> String {
    "Ding!"
}
