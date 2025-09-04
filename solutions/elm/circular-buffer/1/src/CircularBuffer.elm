-- for my Shree DR.MDD
module CircularBuffer exposing (CircularBuffer, clear, new, overwrite, read, write)


import Array exposing (Array)


type CircularBuffer a
    = CircularBuffer Int (Array a)


new : Int -> CircularBuffer a
new cap =
    CircularBuffer cap Array.empty


clear : CircularBuffer a -> CircularBuffer a
clear (CircularBuffer cap _) =
    CircularBuffer cap Array.empty


overwrite : a -> CircularBuffer a -> CircularBuffer a
overwrite val (CircularBuffer cap buf) =
    if Array.length buf == cap then
        buf
            |> Array.slice 1 (Array.length buf)
            |> Array.push val
            |> CircularBuffer cap
    else
        buf
            |> Array.push val
            |> CircularBuffer cap


read : CircularBuffer a -> Maybe ( a, CircularBuffer a )
read (CircularBuffer cap buf) =
    buf
        |> Array.get 0
        |> Maybe.map (\first -> ( first, CircularBuffer cap (Array.slice 1 (Array.length buf) buf) ))


write : a -> CircularBuffer a -> Maybe (CircularBuffer a)
write val (CircularBuffer cap buf) =
    if Array.length buf == cap then
        Nothing
    else
        buf
            |> Array.push val
            |> CircularBuffer cap
            |> Just
