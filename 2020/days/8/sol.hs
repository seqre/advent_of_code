module Main (main) where

import Data.List 
import qualified Data.Map as M

data Action = Acc | Jmp | Nop deriving (Show,Eq)

data CMD = CMD { action :: Action
               , number :: Int
               , visited :: Int
               } deriving (Show,Eq)

data GameBoy = GB { commands :: Data
                  , index :: Int
                  , accumulator :: Int
                  } deriving (Show)

type Data = M.Map Int CMD

main :: IO()
main = do
        raw_input <- readFile "input.txt"
        let cln = map ((\[a,b] -> (a, splitAt 1 b)).words) $ lines raw_input
        let parsed = parse cln
        print ("Sol 1: " ++ (show $ sol1 parsed))
        print ("Sol 2: " ++ (show $ findAnswer $ getAlterations $ commands parsed))

findAnswer :: [Data] -> Int
findAnswer (d:ds) = maybe (findAnswer ds) id $ sol2 (GB d 0 0)

getAlterations :: Data -> [Data]
getAlterations m = filter (not.null) $ map (changeAcc m) [0..M.size m]
                   where
                           changeAccIn :: CMD -> CMD
                           changeAccIn y = case action y of
                                             Jmp -> CMD Nop (number y) (visited y)
                                             Nop -> CMD Jmp (number y) (visited y)

                           changeAcc :: Data -> Int -> Data
                           changeAcc x i = let el = x M.! i
                                           in  if action el == Acc
                                               then M.empty
                                               else M.adjust changeAccIn i x

parse :: [(String,(String,String))] -> GameBoy
parse [] = GB M.empty 0 0
parse l = GB (listToMap $ getComm l) 0 0
          where
                  getComm :: [(String,(String,String))] -> [CMD]
                  getComm [] = []
                  getComm ((acc,num):xs) = CMD (getAcc acc) (getNum num) 0 : getComm xs
                  
                  getAcc acc | acc == "acc" = Acc
                             | acc == "jmp" = Jmp
                             | acc == "nop" = Nop
                  
                  getNum (sign,val) = if sign == "+" then read val::Int else -(read val::Int)

listToMap :: [CMD] -> Data
listToMap l = M.fromList $ zip [0..] (l ++ [CMD Nop 0 (-1)])

sol1 :: GameBoy -> Int
sol1 (GB comms index acc) = let comm = comms M.! index
                                new_comm = M.adjust (\(CMD a n v) -> CMD a n (v + 1)) index comms
                            in  if visited comm == 1 then acc else
                                case action comm of
                                  Acc -> sol1 (GB new_comm (index + 1) (acc + number comm))
                                  Jmp -> sol1 (GB new_comm (index + number comm) acc)
                                  Nop -> sol1 (GB new_comm (index + 1) acc)

sol2 :: GameBoy -> Maybe Int
sol2 (GB comms index acc) = let comm = maybe (CMD Nop 0 10) id $ comms M.!? index
                                new_comm = M.adjust (\(CMD a n v) -> CMD a n (v + 1)) index comms
                            in  if visited comm == -1 then Just acc else
                                if visited comm >= 10 then Nothing else
                                case action comm of
                                  Acc -> sol2 (GB new_comm (index + 1) (acc + number comm))
                                  Jmp -> sol2 (GB new_comm (index + number comm) acc)
                                  Nop -> sol2 (GB new_comm (index + 1) acc)
