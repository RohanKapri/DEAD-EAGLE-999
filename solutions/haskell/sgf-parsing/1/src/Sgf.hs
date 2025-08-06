{-# LANGUAGE ImportQualifiedPost #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-unused-do-bind #-}
module Sgf (parseSgf) where
import Control.Applicative (asum, many, (<|>))
import Data.Attoparsec.Text (
    Parser,
    char,
    digit,
    letter,
    many1,
    parseOnly,
    satisfy,
 )
import Data.Char (isUpper)
import Data.Functor (($>))
import Data.Text qualified as T
import Data.Map (Map)
import Data.Map qualified as Map
import Data.Text (Text)
import Data.Tree (Tree (..))
type SgfTree = Tree SgfNode
type SgfNode = Map Text [Text]
parseSgf :: Text -> Maybe SgfTree
parseSgf sgf = either (const Nothing) Just $ parseOnly pTree sgf
pNode :: Parser SgfNode
pNode = Map.unions <$> (char ';' *> many pProperty)
pProperty :: Parser SgfNode
pProperty = do
    key <- T.pack <$> pKey
    values <- fmap T.pack <$> many1 pValue
    return $ Map.fromList [(key, values)]
pKey :: Parser String
pKey = many1 (satisfy isUpper)
pValue :: Parser String
pValue = char '[' *> pValueInterior <* char ']'
  where
    lits = " \n[;()=" :: String
    pLiterals = letter <|> digit <|> asum (fmap char lits)
    pSubstitutions = char '\t' $> ' '
    escaped = ['\\', ']', 't', 'n']
    pEscaped = (char '\\' *> char '\t' $> ' ') <|> asum [char '\\' *> char c | c <- escaped]
    pNull = char '\\' *> char '\n' $> ""
    pValueInterior = fmap concat <$> many1 $ many1 (pLiterals <|> pSubstitutions <|> pEscaped) <|> pNull
pTree :: Parser SgfTree
pTree = do
    char '('
    pathNodes <- many1 pNode
    tailChildren <- many pTree
    char ')'
    case pathNodes of
        [] -> return $ error "many1 cannot parse empty list"
        _ -> return $ toPath tailChildren pathNodes
toPath :: [SgfTree] -> [SgfNode] -> SgfTree
toPath _ [] = undefined
toPath children [x] = Node x children
toPath children (x : xs) = Node x [toPath children xs]