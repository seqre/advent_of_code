module Main (main) where

import Data.List
import Data.Map (Map, fromList, findWithDefault, size, toAscList, mapWithKey, findMin, findMax)
import qualified Data.Map as M (filter)

type Map2D = Map (Int, Int) Char

main :: IO()
main = do
        raw_input <- readFile "input.txt"
        let parsed = parse raw_input
        print $ "Sol 2: " ++ show (sol2 parsed 0)

sol2 :: Map2D -> Int -> Int
sol2 mp prev = let stepped = step mp
                   taken = countTaken stepped
	       in  if taken == prev then taken
		                    else sol2 stepped taken

parse :: String -> Map2D
parse input = fromList tuples
              where
	              rows = zip [0..] $ lines input
	              mapRow (ind, list) = foldl (\acc el -> ((fromInteger ind, length acc), el) : acc ) [] list
                      tuples = concatMap mapRow rows

printMap :: Map2D -> String
printMap mp = foldl func "" (toAscList mp) ++ "\n"
              where
                      func acc ((_,y),v) = if y == 0 then acc ++ "\n" ++ [v] 
                                                     else acc ++ " " ++ [v]

step :: Map2D -> Map2D
step mp = mapWithKey (getState mp) mp
		  
getState :: Map2D -> (Int, Int) -> Char -> Char
getState mp c@(x, y) val | val == 'L' && num == 0 = '#'
                         | val == '#' && num >= 5 = 'L'
		         | otherwise              = val
                         where num = countActive mp c

getVectors :: [(Int, Int)]
getVectors = [(a,b) | a <- [-1..1], b <- [-1..1], (a,b) /= (0,0)]

countActive :: Map2D -> (Int, Int) -> Int
countActive mp c@(x, y) = length $ filter (== '#') vals
                          where
			          neighbors = map (findSeat mp c) getVectors
				  vals = map (\k -> findWithDefault '.' k mp) neighbors

findSeat :: Map2D -> (Int, Int) -> (Int, Int) -> (Int, Int)
findSeat mp (x, y) (a, b) = let point@(x', y') = (x + a, y + b)
                                (hor, vert) = getLimits mp
                                val = findWithDefault '.' point mp
			    in  if 0 <= x' && x' <= hor && 0 <= y' && y' <= vert
	                        then if val /= '.' then point
				                   else findSeat mp point (a,b)
				else point

countTaken :: Map2D -> Int
countTaken = size . M.filter (== '#')

getLimits :: Map2D -> (Int, Int)
getLimits mp = fst $ findMax mp
