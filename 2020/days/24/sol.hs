module Main (main) where

import Data.List (nub)
import Data.Map (Map, empty, alter, size, findWithDefault, mapWithKey, keys)
import qualified Data.Map as M (filter)

type Point   = (Int, Int)
type TileMap = Map Point Bool

main :: IO()
main = do
	input <- readFile "input.txt"
        let parsed = parse input
        print $ "Sol 1: " ++ show (sol1 parsed)
        print $ "Sol 2: " ++ show (sol2 parsed)

sol1 :: [String] -> Int
sol1 list = size $ M.filter (== True) mp
            where
		    points = map (getPoint (0,0)) list
		    mp     = foldl changeTile empty points

sol2 :: [String] -> Int
sol2 list = size $ M.filter (== True) mp'
            where
		    points = map (getPoint (0,0)) list
                    mp     = foldl changeTile empty points
		    mp'    = iterate dayStep mp !! 100

parse :: String -> [String]
parse = lines

changeTile :: TileMap -> Point -> TileMap
changeTile mp point = alter inner point mp
                      where
			      inner Nothing  = Just (True)
			      inner (Just x) = Just (not x)

getPoint :: Point -> String -> Point
getPoint point ""             = point
getPoint point ('e':rest)     = getPoint (addPoints point (2, 0))   rest
getPoint point ('w':rest)     = getPoint (addPoints point (-2, 0))  rest
getPoint point ('n':'e':rest) = getPoint (addPoints point (1, 1))   rest
getPoint point ('n':'w':rest) = getPoint (addPoints point (-1, 1))  rest
getPoint point ('s':'w':rest) = getPoint (addPoints point (-1, -1)) rest
getPoint point ('s':'e':rest) = getPoint (addPoints point (1, -1))  rest

addPoints :: Point -> Point -> Point
addPoints (l1, r1) (l2, r2) = (l1 + l2, r1 + r2)

getNeighbours :: Point -> [Point]
getNeighbours point = map (addPoints point) [(2,0), (-2,0), (1,1), (-1,1), (-1,-1), (1,-1)]

getBlacks :: TileMap -> [Point] -> Int
getBlacks mp = length . filter (== True) . map (\p -> findWithDefault False p mp)

dayStep :: TileMap -> TileMap
dayStep mp = mapped
             where
		     neighbours = nub . concatMap getNeighbours $ keys mp
		     neutral Nothing  = Just False
		     neutral (Just x) = Just x
		     extended = foldl (\mup point -> alter neutral point mup) mp neighbours
		     mapped = mapWithKey (getState mp) extended

getState :: TileMap -> Point -> Bool -> Bool
getState mp point val | val && (num == 0 || num > 2) = False
                      | not val && num == 2          = True
		      | otherwise                    = val
		      where num = getBlacks mp $ getNeighbours point
