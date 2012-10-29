{-
Triangle, pentagonal, and hexagonal numbers are generated by the following
formulae:

  Triangle     T(n) = n(n+1)/2      1, 3, 6, 10, 15, ...
  Pentagonal   P(n) = n(3n-1)/2     1, 5, 12, 22, 35, ...
  Hexagonal    H(n) = n(2n-1)       1, 6, 15, 28, 45, ...

It can be verified that T(285) = P(165) = H(143) = 40755.
Find the next triangle number that is also pentagonal and hexagonal.
-}

module Main where

-- triangle number function
t :: Int -> Int
t n = (n*(n+1)) `div` 2

-- pentagonal number function
p :: Int -> Int
p n = (n*(3*n-1)) `div` 2

-- hexagonal number function
h :: Int -> Int
h n = n*(2*n-1)

-- check elem of triple is equals or not
equalTriple :: (Int, Int, Int) -> Bool
equalTriple (x,y,z) = (x == y) && (y == z)

-- return verified number indexs
verifiedIdxs :: [Int] -> [[Int]]
verifiedIdxs (x:y:z:_)
    | equalTriple (valT,valP,valH) = [x,y,z] : verifiedIdxs [x+1,y,z]
    | minVal == valT = verifiedIdxs [x+1,y,z]
    | minVal == valP = verifiedIdxs [x,y+1,z]
    | minVal == valH = verifiedIdxs [x,y,z+1]
    where
      (valT,valP,valH) = (t x, p y, h z)
      minVal = minimum [valT, valP, valH]

-- number that triangle, pentagonal and hexagonal.
verifiedNums :: [Int]
verifiedNums = map (t . head) $ verifiedIdxs [1,1,1]

main = print $ (!!2) verifiedNums  -- verifiedNums = [1,40755, ..], so get idx 2