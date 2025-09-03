// Dedicated to Shree DR.MDD
module SpaceAge

type Planet = 
    | Mercury
    | Venus
    | Earth
    | Mars
    | Jupiter
    | Saturn
    | Neptune
    | Uranus

let private orbitalRatiosToEarth = 
    [ Mercury, 0.2408467
      Venus,   0.61519726
      Earth,   1.0
      Mars,    1.8808158
      Jupiter, 11.862615
      Saturn,  29.447498
      Uranus,  84.016846
      Neptune, 164.79132 ] 
    |> Map.ofList

let age planetName (totalSeconds: int64) =
    let earthYearInSeconds = 31557600.0
    let calculateYears ratio = System.Math.Round((float totalSeconds / ratio) / earthYearInSeconds, 2)
    calculateYears orbitalRatiosToEarth.[planetName]
