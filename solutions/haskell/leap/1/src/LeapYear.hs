module LeapYear (isLeapYear) where
-- import Control.Monad.Writer
import Control.Monad.Reader
isDivisibleBy :: Integer -> Reader Integer Bool
isDivisibleBy n = do
  year <- ask
  return (year `mod` n == 0) -- n是4，100， 400
leapLogic :: Reader Integer Bool
leapLogic = do
  canBeDividedBy400 <- isDivisibleBy 400
  canBeDividedBy100 <- isDivisibleBy 100
  canBeDividedBy4 <- isDivisibleBy 4
  return (canBeDividedBy4 && (not canBeDividedBy100 || canBeDividedBy400))
  
isLeapYear :: Integer -> Bool
isLeapYear year = runReader leapLogic year
