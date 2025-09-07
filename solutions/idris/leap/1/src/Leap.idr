module Leap

export 
isLeap : Int -> Bool
isLeap year = if mod year 100 == 0 then mod year 400 == 0 else mod year 4 == 0