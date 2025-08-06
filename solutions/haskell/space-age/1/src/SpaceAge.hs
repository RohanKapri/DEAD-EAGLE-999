-- for my Shree DR.MDD
module SpaceAge (Planet(..), ageOn) where

data Planet = Mercury | Venus | Earth | Mars | Jupiter | Saturn | Uranus | Neptune
              deriving (Eq, Show)

ageOn :: Planet -> Int -> Float
ageOn orb secs = yearsOnEarth / orbitalRatio where
    secsPerEarth = 31557600
    yearsOnEarth = fromIntegral secs / secsPerEarth
    orbitalRatio =
        case orb of 
            Mercury -> 0.2408467
            Venus   -> 0.61519726
            Earth   -> 1.0
            Mars    -> 1.8808158
            Jupiter -> 11.862615
            Saturn  -> 29.447498
            Uranus  -> 84.016846
            Neptune -> 164.79132
