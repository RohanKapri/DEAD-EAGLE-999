module CarsAssemble

let successRate speed = 
    match speed with
        | 0 -> 0.0
        | n when n <= 4 -> 1.0
        | n when n <= 8 -> 0.9
        | 9 -> 0.8
        | _ -> 0.77

let productionRatePerHour (speed: int): float =
    float speed * float 221 * successRate speed

let workingItemsPerMinute (speed: int): int =
   (productionRatePerHour >> int) speed / 60