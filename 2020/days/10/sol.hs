module Main (main) where

import Data.List
import Data.Map (Map, empty, fromList, adjust, (!), insert, findWithDefault)
import Debug.Trace (trace)

main :: IO()
main = do
        raw_input <- readFile "input.txt"
        let parsed = sort.map (\x -> read x::Int) $ lines raw_input
        print $ take 20 parsed
        print $ "Sol 1: " ++ show (sol1 parsed)
        print $ "Sol 2: " ++ show (sol2 parsed)

getDeviceRating :: [Int] -> Int
getDeviceRating [] = -1
getDeviceRating l = maximum l + 3

sol1 :: [Int] -> Int
sol1 [] = -1
sol1 l = let chain = findChain l 0 (getDeviceRating l) $ fromList [(1,0),(2,0),(3,0)]
         in (chain ! 1) * (chain ! 3)

findChain :: [Int] -> Int -> Int -> Map Int Int -> Map Int Int
findChain [] joint dr mp = let diff = dr - joint
                               new_mp = adjust (+ 1) diff mp
                           in  new_mp
findChain list joint dr mp = if null options
                             then findChain [] joint dr mp
                             else findChain new_list new_adapter dr new_mp
                             where
                                     options = takeWhile (\x -> x - joint <= 3) list
                                     new_adapter = head options
                                     diff = new_adapter - joint
                                     new_list = dropWhile (<= new_adapter) list
                                     new_mp = adjust (+ 1) diff mp

sol2 :: [Int] -> Int
sol2 list = mp ! last_num
            where
                    mp = countChains list $ fromList [(0,1)]
                    last_num = last list

countChains :: [Int] -> Map Int Int -> Map Int Int
countChains []     mp = mp
countChains (l:ls) mp = countChains ls new_mp
                        where
                                find mp' k = findWithDefault 0 k mp'
                                minus_sum = sum $ map (find mp) [l-3..l-1]
                                new_mp  = Data.Map.insert l minus_sum mp
