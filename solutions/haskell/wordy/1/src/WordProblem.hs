module WordProblem (answer) where
import Text.Parsec ( try, char, digit, string, many1, (<|>), many, parse )
import Text.Parsec.String (Parser)
import Data.Either.Extra
answer :: String -> Maybe Integer
answer problem = eitherToMaybe $ parse parseProblem "WordProblems.hs" problem
parseProblem :: Parser Integer
parseProblem = do
    _ <- string "What is "
    num <- parseNumber
    ops <- many parseTerm
    let z = foldl (\n f -> f n) num ops
    return z
parseTerm :: Parser (Integer -> Integer)
parseTerm = do
    f <- parseOp
    num <- parseNumber
    return (`f` num)
parseOp :: Parser (Integer -> Integer -> Integer)
parseOp = try parsePlus <|> try parseMinus <|> try parseMultipliedBy <|> parseDividedBy
    where
        parsePlus = string " plus " >> return (+)
        parseMinus = string " minus " >> return (-)
        parseMultipliedBy = string " multiplied by " >> return (*)
        parseDividedBy = string " divided by " >> return div
parseNumber :: Parser Integer
parseNumber = try negative <|> positive
    where
        negative = char '-' >> positive >>= (\n -> return (-n))
        positive = many1 digit >>= (return . read)
