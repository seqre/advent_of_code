module Main (main) where

import Data.List

main :: IO()
main = do
        raw_input <- readFile "input.txt"
        let groups = groupBy (\x y -> y /= "") $ lines raw_input
        let cln_groups = map (filter (/="")) groups
        print ("Sol 1: " ++ (show $ sol1 cln_groups))
        print ("Sol 2: " ++ (show $ sol2 cln_groups))

sol1 :: [[String]] -> Int
sol1 [] = 0
sol1 l = sum $ map (length.nub.sort.concat) l

sol2 :: [[String]] -> Int
sol2 [] = 0
sol2 l = sum $ map (length.nub.sort.foldl intersect ['a'..'z']) l
