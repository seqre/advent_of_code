module Main (main) where

import Prelude hiding (Left,Right)


data Direction = N | S | E | W deriving (Show, Eq)

data Action = North | South | East | West | Left | Right | Forward deriving (Show, Eq)

data Instruction = IN {act :: Action, val :: Int} deriving (Show)

data Ship = SH {facing :: Direction, pos_e :: Int, pos_n :: Int} deriving (Show)


main :: IO()
main = do
        raw_input <- readFile "input.txt"
        let parsed = parse $ lines raw_input
        print $ "Sol 1: " ++ show (sol1 parsed)

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


sol1 :: [Instruction] -> Int
sol1 ins = abs (pos_n sh) + abs (pos_e sh)
           where
		   sh = moveShip (SH E 0 0) ins

moveShip :: Ship -> [Instruction] -> Ship
moveShip sh [] = sh
moveShip sh (i:is) | act i == North   = moveShip (SH (facing sh) (pos_e sh) (pos_n sh + val i)) is
                   | act i == South   = moveShip (SH (facing sh) (pos_e sh) (pos_n sh - val i)) is
                   | act i == East    = moveShip (SH (facing sh) (pos_e sh + val i) (pos_n sh)) is
                   | act i == West    = moveShip (SH (facing sh) (pos_e sh - val i) (pos_n sh)) is
                   | act i == Forward = moveShip sh $ IN (facingToAction (facing sh)) (val i) : is
                   | otherwise        = moveShip (SH (changeFacing (facing sh) (act i) (val i)) (pos_e sh) (pos_n sh)) is

changeFacing :: Direction -> Action -> Int -> Direction
changeFacing dir side val = if side == Right then get_n base_r 
					     else get_n base_l
                            where
				    repetitions = div val 90
				    base_r = cycle [N,E,S,W]
				    base_l = cycle [N,W,S,E]
				    get_n list = dropWhile (/= dir) list !! repetitions



facingToAction :: Direction -> Action
facingToAction N = North
facingToAction E = East
facingToAction S = South
facingToAction W = West
