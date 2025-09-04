module SpaceAge exposing (Planet(..), ageOn)

-- Define all planets
type Planet
    = Mercury
    | Venus
    | Earth
    | Mars
    | Jupiter
    | Saturn
    | Uranus
    | Neptune


-- Age on a given planet (in years)
ageOn : Planet -> Float -> Float
ageOn planet seconds =
    seconds / secondsPerEarthYear / earthYearsPerOrbit planet


-- Seconds in one Earth year (365.25 days)
secondsPerEarthYear : Float
secondsPerEarthYear =
    31557600


-- Orbital period of each planet in Earth years
earthYearsPerOrbit : Planet -> Float
earthYearsPerOrbit planet =
    case planet of
        Mercury ->
            0.2408467

        Venus ->
            0.61519726

        Earth ->
            1.0

        Mars ->
            1.8808158

        Jupiter ->
            11.862615

        Saturn ->
            29.447498

        Uranus ->
            84.016846

        Neptune ->
            164.79132
