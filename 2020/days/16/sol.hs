module Main (main) where

import Data.List (sortBy, isPrefixOf, delete)
import Data.List.Split (splitOn)
import Data.Bifunctor (second)
import Debug.Trace (trace)

type Range = (Int, Int)
type Ticket = [Int]

data Field = F String Range Range deriving (Eq)

instance Show Field where show (F d l h) = "F " ++ d


main :: IO()
main = do
	input <- readFile "input.txt"
        let parsed@(fields, my_ticket, tickets) = parse input
        print $ "Sol 1: " ++ show (sol1 fields tickets)
        print $ "Sol 2: " ++ show (sol2 fields tickets my_ticket)

sol1 :: [Field] -> [Ticket] -> Int
sol1 _      []     = 0
sol1 fields (t:ts) = (if correct then 0 else findIncorrect fields t) + sol1 fields ts
                     where
			     correct = checkTicket fields t

sol2 :: [Field] -> [Ticket] -> Ticket -> Int
sol2 fields tickets ticket = product nums
                             where
				     correct_tickets       = filter (checkTicket fields) tickets
				     assignment            = chooseField [0..length fields - 1] fields correct_tickets
				     departure_assignments = filter (isPrefixOf "departure" . getDesc . snd) assignment
				     indexes               = map fst departure_assignments
				     nums                  = map (ticket !!) indexes


parse :: String -> ([Field], Ticket, [Ticket])
parse input = (fields, my_ticket, tickets)
              where
		      splitted  = splitOn [""] $ lines input
		      (raw_fields, raw_my_ticket, raw_tickets) = (splitted !! 0, splitted !! 1, splitted !! 2)
		      fields    = parseField raw_fields
		      my_ticket = head . parseTicket $ tail raw_my_ticket
		      tickets   = parseTicket $ tail raw_tickets

parseField :: [String] -> [Field]
parseField []     = []
parseField (f:fs) = F desc range1 range2 : parseField fs
                    where
			    splitted           = splitOn ":" f
			    (desc, raw_ranges) = (splitted !! 0, splitted !! 1)
			    ranges             = map parseRange $ splitOn "or" raw_ranges
			    (range1, range2)   = (ranges !! 0, ranges !! 1)

parseTicket :: [String] -> [Ticket]
parseTicket []     = []
parseTicket (t:ts) = parsed : parseTicket ts
                     where
			     parsed = map (\x -> read x :: Int) $ splitOn "," t

parseRange :: String -> Range
parseRange input = (low, high)
                   where
			   raw         = map (\x -> read x :: Int) $ splitOn "-" input
			   (low, high) = (raw !! 0, raw !! 1)

checkTicket :: [Field] -> Ticket -> Bool
checkTicket []     _      = False
checkTicket fields ticket = all checkVal ticket
                            where
				    ranges               = concat $ map getRanges fields
				    checkVal v           = any (valInRange v) ranges

getRanges :: Field -> [Range]
getRanges (F _ l h) = [l, h]

getDesc :: Field -> String
getDesc (F desc _ _) = desc

valInRange :: Int -> Range -> Bool
valInRange val (low, high) = low <= val && val <= high

findIncorrect :: [Field] -> Ticket -> Int
findIncorrect fields ticket = head incorrect
                              where
				      ranges               = concat $ map getRanges fields
				      checkVal v           = any (valInRange v) ranges
				      incorrect            = filter (not . checkVal) ticket

chooseField :: [Int] -> [Field] -> [Ticket] -> [(Int, Field)]
chooseField indexes fields tickets = mps sorted
                                     where
    					 vals x = map (!! x) tickets
					 values = map vals indexes
					 check_val f [] = True
                                         check_val f (v:vs) = check_val f vs && any (valInRange v) (getRanges f)
					 check_list v =  filter (flip check_val v) fields
    					 fields_counted = map (second check_list) $ zip indexes values
					 sorted = sortBy (\(_, la) (_,lb) -> compare (length la) (length lb)) fields_counted

					 mps :: [(Int, [Field])] -> [(Int, Field)]
					 mps []                 = []
					 mps ((ind, list):rest) = let f = head list
					                          in (ind, f) : mps (map (second (delete f)) rest)
