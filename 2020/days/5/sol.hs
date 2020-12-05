module Main (main) where

import Data.List
import Data.Bool

main :: IO()
main = do
        raw_input <- readFile "input.txt"
        let passes = map (splitAt 7) $ lines raw_input
        print ("Sol 1: " ++ (show $ sol1 passes))
        print ("Sol 2: " ++ (show $ sol2 passes))

findSeat :: (String,String) -> (Int,Int)
findSeat ("","") = (-1,-1)
findSeat (x,y) = let binFind :: String -> Char -> Int -> Int
                     binFind "" _ _ = 0
                     binFind (x:xs) low seats = let half = div seats 2
                                                in  if x == low then binFind xs low half
                                                                else half + binFind xs low half
                 in (binFind x 'F' 128, binFind y 'L' 8)

sol1 :: [(String,String)] -> Int
sol1 [] = -1
sol1 passes = maximum $ map ((\(x,y) -> x * 8 + y) . findSeat) passes

sol2 :: [(String,String)] -> Int
sol2 [] = -1
sol2 passes = let seats = sort $ map ((\(x,y) -> x * 8 + y) . findSeat) passes
                  findMissing :: [Int] -> Int
                  findMissing [] = -1
                  findMissing (x:xs) = if x + 1 == head xs then findMissing xs else x + 1
              in  findMissing seats
