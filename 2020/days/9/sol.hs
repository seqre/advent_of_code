module Main (main) where

import Data.List

main :: IO()
main = do
        raw_input <- readFile "input.txt"
        let parsed = map (\x -> read x::Int) $ lines raw_input
        print $ take preambleLen parsed
        let sol_one = sol1 parsed
        print ("Sol 1: " ++ (show $ sol_one))
        print ("Sol 2: " ++ (show $ sol2 parsed sol_one))

preambleLen :: Int
preambleLen = 25

hasSummingPair :: [Int] -> Int -> Bool
hasSummingPair [] _ = False
hasSummingPair l n = let pairs = [(x,y) | x <- l, y <- l, x /= y, x + y == n]
                     in  length pairs > 0

sol1 :: [Int] -> Int
sol1 [] = -1
sol1 l  = if not result then num else sol1 $ tail l
          where 
                  (preamble,rest) = splitAt preambleLen l
                  num = head rest
                  result = hasSummingPair preamble num

sol2 :: [Int] -> Int -> Int
so2 [] _ = -1
sol2 l x = sumSmallLarge.head.(filter (\x -> length x > 1)) $ subseqs
           where
                   sumSmallLarge = (\li -> head li + last li).sort
                   subseqs = caterpillar l 0 x
                   
caterpillar :: [Int] -> Int -> Int -> [[Int]]
caterpillar [] _ _ = []
caterpillar list len val = let sub_list = take len list
                               sub_sum = sum sub_list
                           in  if sub_sum == val
                               then sub_list : caterpillar (tail list) (len + 1) val
                               else if sub_sum > val
                                    then caterpillar (tail list) 0 val
                                    else caterpillar list (len + 1) val
