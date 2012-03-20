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

-- day
data Day = SUNDAY | MONDAY | TUESDAY | WEDNESDAY | THURSDAY | FRIDAY | SATURDAY
           deriving (Eq,Show)

-- day calculator
step_day :: Day -> Int -> Day
step_day day 0 = day
step_day day (n+1) = step_day (next_day day) n

next_day :: Day -> Day
next_day day = case day of
                 SUNDAY -> MONDAY
                 MONDAY -> TUESDAY
                 TUESDAY -> WEDNESDAY
                 WEDNESDAY -> THURSDAY
                 THURSDAY -> FRIDAY
                 FRIDAY -> SATURDAY
                 SATURDAY -> SUNDAY

-- check year is leap?
is_leap :: Int -> Bool
is_leap y = (y `mod` 4 == 0) && ((y `mod` 100 /= 0) || (y `mod` 400 == 0))

-- how many days in each month.
days_lst      = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days_lst_leap = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

-- number of days at given year -- XXX: can't be defined as list?
nday_in_year :: Int -> Int
nday_in_year year = if is_leap year
                    then sum days_lst_leap
                    else sum days_lst

-- first days of each year
fst_day_year :: Int -> Day
fst_day_year 1900 = MONDAY
fst_day_year (n+1) = step_day (fst_day_year n) (nday_in_year n)

-- return first days list of given year.
fst_days :: Int -> [Day]
fst_days n = let st = fst_day_year n
                 dl = if is_leap n
                      then days_lst_leap
                      else days_lst
             in [step_day st (sum $ take d dl) | d <- [0..11]]

-- count of the first dai of the month is Sunday.
num_fst_sunday :: Int -> Int
num_fst_sunday n = let fds = fst_days n
                   in
                     length $ filter (\d -> d == SUNDAY) fds

-- solve problem
solve :: Int -> Int -> Int
solve start end = sum $ map num_fst_sunday [start .. end]

main = print $ solve 1901 2000  -- count 1901 to 2000
