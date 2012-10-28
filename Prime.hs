{-
Prime module : My original PRIME functions.
-}

module Prime (primesUnder) where

import Control.Monad
import Control.Monad.ST
import Data.Array.ST

-- prime number list under n.
primesUnder :: Int -> [Int]
primesUnder n = runST $ eratoshnes n

-- eratoshnes sieve algorithm.
eratoshnes n = do
  boolArrs <- newArray (2,n-1) True :: ST s (STUArray s Int Bool)
  let sieve x = mapM_ (\z -> writeArray boolArrs z False) [(2*x),(3*x)..(n-1)]
  forM_ [2..(n-1)] $ \idx -> do
    isPrime <- readArray boolArrs idx
    if isPrime then sieve idx else return ()
  pairs <- fmap (zip [2..]) $ getElems boolArrs
  return $ map fst $ filter snd pairs
