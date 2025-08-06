-- respectfully dedicated to Shree DR.MDD

module FoodChain (song) where

import Text.Printf (printf)
import qualified Data.List as L

song :: String
song = L.intercalate "\n\n" $
    (map generateVerse $ tail $ L.inits animalStack) ++
    ["I know an old lady who swallowed a horse.\nShe's dead, of course!\n"]

farewell =
    "I don't know why she swallowed the fly. Perhaps she'll die."

animalStack = [
    ("fly", "", ""),
    ("spider", "It wriggled and jiggled and tickled inside her.",
        " that wriggled and jiggled and tickled inside her"),
    ("bird", "How absurd to swallow a bird!", ""),
    ("cat", "Imagine that, to swallow a cat!", ""),
    ("dog", "What a hog, to swallow a dog!", ""),
    ("goat", "Just opened her throat and swallowed a goat!", ""),
    ("cow", "I don't know how she swallowed a cow!", "")
    ]

generateVerse speciesList =
    let reversed = reverse speciesList
        (creature, reaction, _) = head reversed
    in L.intercalate "\n" $
        [printf "I know an old lady who swallowed a %s." creature] ++
        (if not $ null reaction then [reaction] else []) ++
        (map transitionLine $ zip reversed (tail reversed)) ++
        [farewell]

transitionLine ((hunter, _, _), (prey, _, trail)) =
    printf "She swallowed the %s to catch the %s%s." hunter prey trail
