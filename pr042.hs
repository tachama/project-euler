{-
The nth term of the sequence of triangle numbers is given by, t(n) = 1/2 * n(n+1);
so the first ten triangle numbers are:

  1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

By converting each letter in a word to a number corresponding to its alphabetical
position and adding these values we form a word value. For example, the word
value for SKY is 19 + 11 + 25 = 55 = t10. If the word value is a triangle number
then we shall call the word a triangle word.

Using words.txt (right click and 'Save Link/Target As...'), a 16K text file
containing nearly two-thousand common English words, how many are triangle words?
-}

module Main where

import Data.Char (ord, toUpper)
import Data.List (unfoldr)

-- problem input file name.
infile :: String
infile = "pr042_words.txt"

-- split string with char
split :: Char -> String -> [String]
split c ss = unfoldr func $ "," ++ ss  -- add ',' first for common procedure.
             where
               func [] = Nothing
               func s = Just (t1, t2) where (t1, t2) = break (==c) $ tail s

-- word expression to string; "WORD" -> WORD
toWord :: String -> String
toWord = init . tail


-- triangle numbers
triangleNumbers :: [Int]
triangleNumbers = [(n * (n + 1)) `div` 2 | n <- [1..]]

-- check whether number is triangle or not
isTriangleNum :: Int -> Bool
isTriangleNum n = any (==n) $ takeWhile (<=n) triangleNumbers

-- check whether word is triangle word or not
isTriangleWord :: String -> Bool
isTriangleWord ss = isTriangleNum $ sum $ map wordNumber ss
                    where
                      wordNumber c = (ord . toUpper) c - ord 'A' + 1

main = do
  wordList <- fmap (map toWord . split ',') $ readFile infile
  print $ length $ filter isTriangleWord wordList
