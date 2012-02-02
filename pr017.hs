{-
If the numbers 1 to 5 are written out in words: one, two, three, four, five,
then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

If all the numbers from 1 to 1000 (one thousand) inclusive were written out
in words, how many letters would be used?


NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
forty-two) contains 23 letters and 115 (one hundred and fifteen) contains
20 letters. The use of "and" when writing out numbers is in compliance with
British usage.
-}

module Main where

input_num :: Int
input_num = 1000

-- letters for 1 to 19
digit_str :: [String]
digit_str =  [ "", "one", "two", "three", "four", "five", "six",
               "seven", "eight", "nine", "ten", "eleven", "twelve",
               "thirteen", "fourteen", "fifteen", "sixteen", "seventeen",
               "eighteen", "nineteen" ]

-- letters for 20, 30, 40, ...
digit10_str :: [String]
digit10_str = [ "", "", "twenty", "thirty", "forty", "fifty",
                "sixty", "seventy", "eighty", "ninety" ]

-- for thousand and hundred
letter_sub1 :: Int -> String -> String
letter_sub1 0 _ = []
letter_sub1 n base = (head $ drop n digit_str) ++ base

-- for below 100
letter_sub2 :: Int -> String
letter_sub2 n | n < 20 = head $ drop n digit_str
              | otherwise = (head $ drop (n `div` 10) digit10_str)
                            ++ (head $ drop (n `mod` 10) digit_str)

-- "and" if needed.
and_if_needs :: Int -> Int -> String
and_if_needs 0 _ = []
and_if_needs _ n | n == 0 = []
                 | otherwise = "and"

-- return letters of n : XXX - need optimization?
--  XXX: 1002 return "one thousand and and two"...
letter :: Int -> String
letter n = (letter_sub1 d1 "thousand")
           ++ (and_if_needs d1 m1)
           ++ (letter_sub1 d2 "hundred")
           ++ (and_if_needs d2 m2)
           ++ (letter_sub2 m2)
           where
             d1 = n `div` 1000
             m1 = n `mod` 1000
             d2 = m1 `div` 100
             m2 = m1 `mod` 100

-- solve problem
solve :: Int -> Int
solve n = sum $ map (length . letter) [1..n]

main = print $ solve input_num