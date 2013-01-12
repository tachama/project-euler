{-
Prime module : My original PRIME functions.
-}

module Prime (primes, primesUnder, primesArrUnder) where

import Control.Monad
import Control.Monad.ST
import Data.Array
import Data.Array.ST

-- infiniti list of primes
primes :: (Integral a) => [a]
primes = 2:[n | n <- [3,5..], all (\x -> n `mod` x /= 0) [3,5..(n-1)]]

-- prime number list under n.
primesUnder :: Int -> [Int]
primesUnder n = runST $ eratoshnes n

-- primes number array under n
--   return pair as (length, array), index of array is "0,1,2..."
primesArrUnder :: Int -> (Int, Array Int Int)
primesArrUnder n = (len, listArray (0, len - 1) prs)
                   where
                     prs = primesUnder n
                     len = length prs

-- eratoshnes sieve algorithm.
eratoshnes n = do
  boolArrs <- newArray (2,n-1) True :: ST s (STUArray s Int Bool)
  let sieve x = mapM_ (\z -> writeArray boolArrs z False) [(2*x),(3*x)..(n-1)]
  forM_ [2..(n-1)] $ \idx -> do
    isPrime <- readArray boolArrs idx
    if isPrime then sieve idx else return ()
  pairs <- fmap (zip [2..]) $ getElems boolArrs
  return $ map fst $ filter snd pairs
