{-
A unit fraction contains 1 in the numerator. The decimal representation of the
unit fractions with denominators 2 to 10 are given:

  1/2  = 0.5
  1/3  = 0.(3)
  1/4  = 0.25
  1/5  = 0.2
  1/6  = 0.1(6)
  1/7  = 0.(142857)
  1/8  = 0.125
  1/9  = 0.(1)
  1/10 = 0.1

Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be
seen that 1/7 has a 6-digit recurring cycle.

Find the value of d < 1000 for which 1/d contains the longest recurring cycle
in its decimal fraction part.
-}

module Main where

-- problem input: max number
numMax = 1000

-- check whether has cycle from divmod list
hasCycle :: [(Int, Int)] -> (Int, Int) -> Bool
hasCycle [] _ = False
hasCycle (t:ts) d = (t == d) || hasCycle ts d

-- convert recurring cycle parts to string.
cycleParts :: [(Int, Int)] -> (Int, Int) -> String
cycleParts (t:ts) d = if t == d
                      then foldr (++) "" $ map (\x -> show $ fst x) (t:ts)
                      else cycleParts ts d

-- subroutine of recurringCycle
recurring :: Int -> [(Int, Int)] -> String
recurring n xs = let val = (10*) . snd $ last xs
                     d = val `div` n
                     m = val `mod` n
                 in
                   if m == 0
                     then ""  -- dividev by number. has no recurring cycle.
                     else if hasCycle xs (d,m)
                            then cycleParts xs (d,m)
                            else recurring n (xs ++ [(d,m)])

-- recurring cycle number of num
recurringCycle :: Int -> String
recurringCycle n = recurring n [(0,1)]

main = print $ snd $ maximum $ zip (map (length . recurringCycle) lst) lst
       where lst = [1..numMax]