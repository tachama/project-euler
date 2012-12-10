{-
You are given the following information, but you may prefer to do some
research for yourself.

  - 1 Jan 1900 was a Monday.
  - Thirty days has September,
    April, June and November.
    All the rest have thirty-one,
    Saving February alone,
    Which has twenty-eight, rain or shine.
    And on leap years, twenty-nine.
  - A leap year occurs on any year evenly divisible by 4, but not on a
    century unless it is divisible by 400.

How many Sundays fell on the first of the month during the twentieth century
(1 Jan 1901 to 31 Dec 2000)?
-}

module Main where

-- data definition for DAY
data Day = SUNDAY | MONDAY | TUESDAY | WEDNESDAY | THURSDAY | FRIDAY | SATURDAY
           deriving (Eq,Show)

-- 1900 is base year of this problem.
baseYear :: Int
baseYear = 1900

-- year is leap?
isLeap :: Int -> Bool
isLeap n = (n `mod` 4 == 0) && ((n `mod` 100 /= 0) || (n `mod` 400 == 0))

-- day calculators
daysLst :: [Int]
daysLst = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]  -- non-leap
daysLstL :: [Int]
daysLstL = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]  -- leap

isSunday :: Day -> Bool
isSunday d = d == SUNDAY

stepDay :: Int -> Day -> Day
stepDay 0 d = d
stepDay n d = stepDay ((n-1) `mod` 7) (nextDay d)

nextDay :: Day -> Day
nextDay d = case d of
              SUNDAY -> MONDAY
              MONDAY -> TUESDAY
              TUESDAY -> WEDNESDAY
              WEDNESDAY -> THURSDAY
              THURSDAY -> FRIDAY
              FRIDAY -> SATURDAY
              SATURDAY -> SUNDAY

-- years list of
yearDays :: Int -> Day -> ([Day], Day)
yearDays y d = let dl = if isLeap y then daysLstL else daysLst
                   ds = yearDaysSub d dl
               in
                 (init ds, last ds)

yearDaysSub :: Day -> [Int] -> [Day]
yearDaysSub d [] = [d]
yearDaysSub d (n:ns) = let d2 = stepDay n d
                       in
                         d : (yearDaysSub d2 ns)

-- fold function for solve.
f :: [([Day], Day)] -> Int -> [([Day], Day)]
f ds y = ds ++ [yearDays y (snd (last ds))]

-- solve problem.
solve :: Int -> Int -> Int
solve start end = let lst = foldl f [yearDays baseYear MONDAY] [(baseYear+1) .. end]
                      lst2 = drop (start - baseYear) lst
                      lst3 = map fst lst2
                  in
                    sum $ map (length . (filter isSunday)) lst3

-- main function.
main :: IO ()
main = print $ solve 1901 2000
