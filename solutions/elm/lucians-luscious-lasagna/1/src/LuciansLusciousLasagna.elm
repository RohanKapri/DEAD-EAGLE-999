module LuciansLusciousLasagna exposing (elapsedTimeInMinutes, expectedMinutesInOven, preparationTimeInMinutes)
expectedMinutesInOven : Int
expectedMinutesInOven =
    40
preparationTimeInMinutes : Int -> Int
preparationTimeInMinutes layers =
    layers * 2
elapsedTimeInMinutes : Int -> Int -> Int
elapsedTimeInMinutes layers ovenTime =
    preparationTimeInMinutes layers + ovenTime