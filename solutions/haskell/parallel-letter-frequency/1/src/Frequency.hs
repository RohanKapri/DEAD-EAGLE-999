module Frequency (frequency) where
import qualified Data.Char as C
import qualified Data.Map as M
import qualified Data.Text as T
import Control.Parallel.Strategies
frequency :: Int -> [T.Text] -> M.Map Char Int
frequency nWorkers texts = M.unionsWith (+) frequencies
    where
        frequencies = map frequency' texts `using` parBuffer nWorkers rseq
frequency' :: T.Text -> M.Map Char Int
frequency' text = T.foldr updateFreq M.empty $ T.map C.toLower $ T.filter C.isAlpha text
    where
        updateFreq c = M.insertWith (+) c 1