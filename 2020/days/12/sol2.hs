module Main (main) where

import Prelude hiding (Left,Right)


type Pos = (Int, Int)

data Action = North | South | East | West | Left | Right | Forward deriving (Show, Eq)

data Instruction = IN {act :: Action, val :: Int} deriving (Show)

data Ship = SH {ship_pos :: Pos, waypoint_pos :: Pos} deriving (Show)


main :: IO()
main = do
        raw_input <- readFile "input.txt"
        let parsed = parse $ lines raw_input
        print $ "Sol 2: " ++ show (sol2 parsed)

parse :: [String] -> [Instruction]
parse [] = []
parse (l:ls) = convert str : parse ls
               where
	              str = splitAt 1 l
		      convert (acc,val) | acc == "N" = (IN North v)
		                        | acc == "S" = (IN South v)
		                        | acc == "E" = (IN East v)
		                        | acc == "W" = (IN West v)
		                        | acc == "L" = (IN Left v)
		                        | acc == "R" = (IN Right v)
		                        | acc == "F" = (IN Forward v)
			                where
					       v = read val :: Int


sol2 :: [Instruction] -> Int
sol2 ins = abs north + abs east
           where
		   sh = moveShip (SH (0,0) (10,1)) ins
		   (north, east) = ship_pos sh

moveShip :: Ship -> [Instruction] -> Ship
moveShip sh [] = sh
moveShip sh (i:is) | act i == North   = moveShip (SH (ship_pos sh) (addPos (waypoint_pos sh) (0, val i))) is
                   | act i == South   = moveShip (SH (ship_pos sh) (addPos (waypoint_pos sh) (0, - (val i)))) is
                   | act i == East    = moveShip (SH (ship_pos sh) (addPos (waypoint_pos sh) (val i, 0))) is
                   | act i == West    = moveShip (SH (ship_pos sh) (addPos (waypoint_pos sh) (- (val i), 0))) is
                   | act i == Forward = moveShip (SH (newPos (ship_pos sh) (waypoint_pos sh) (val i)) (waypoint_pos sh)) is
                   | otherwise        = moveShip (SH (ship_pos sh) (rotatePos (waypoint_pos sh) (act i) (val i))) is

newPos :: Pos -> Pos -> Int -> Pos
newPos ship waypoint val = addPos ship $ multPos waypoint val

multPos :: Pos -> Int -> Pos
multPos (e, n) val = (e * val, n * val)

addPos :: Pos -> Pos -> Pos
addPos (e1, n1) (e2, n2) = (e1 + e2, n1 + n2)

rotatePos :: Pos -> Action -> Int -> Pos
rotatePos p _ 0 = p
rotatePos p _ 360 = p
rotatePos p Left val = rotatePos p Right (360 - val)
rotatePos (e,n) act val = rotatePos (n, -e) act (val - 90)
