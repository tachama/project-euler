{-
Using names.txt (right click and 'Save Link/Target As...'), a 46K text file
containing over five-thousand first names, begin by sorting it into alphabetical
order. Then working out the alphabetical value for each name, multiply this
value by its alphabetical position in the list to obtain a name score.

For example, when the list is sorted into alphabetical order, COLIN, which is
worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN
would obtain a score of 938 * 53 = 49714.

What is the total of all the name scores in the file?
-}

module Main where

import Char (ord)
import List (sort)

-- problem input file name.
infile = "pr022_names.txt"

-- split string with a character
split :: Char -> String -> [String]
split _ [] = []
split c ss = let isc = (\x -> x == c)
                 (s1, s2) = break isc ss
             in
               s1 : (split c (dropWhile isc s2))

-- convert "\"HOGE\"" (include double-quote)  string to "HOGE"
strpickup :: String -> String
strpickup ss = init $ tail ss

-- alphabetical value
alphval :: String -> Int
alphval ss = sum $ map (\c -> ord(c) - ord('A') + 1) ss

-- multiply tuple
multuple :: (Num a) => (a, a) -> a
multuple t = (fst t) * (snd t)

-- calculate name score.
namescore :: (Int, String) -> Int
namescore (n, ss) = multuple (n, alphval ss)

-- solve problem
solve :: String -> Int
solve ss = let names = map strpickup $ split ',' ss
           in
             sum $ map namescore $ zip [1..] (sort names)

main = do cs <- readFile infile  -- read data from infile
          print $ solve cs

{-
MEMO
  - readFile is used for file IO
  - type of readFile is...
      readFile :: FilePath -> IO String
      type FilePath = String  -- Defined in GHC.IO
-}