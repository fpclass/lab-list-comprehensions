--------------------------------------------------------------------------------
-- Functional Programming (CS141)                                             --
-- Lab: List comprehensions                                                   --
--------------------------------------------------------------------------------

import Test.Hspec
import Test.Hspec.QuickCheck
import Test.QuickCheck

import Data.List (nub)

import qualified Lab as L

--------------------------------------------------------------------------------

-- | Calculates the nth triangle number.
tri :: Int -> Int
tri n = n * (n + 1) `div` 2

-- | Determines whether n is the sum of all multiples of 3 and 5 from 0..m
isSum :: Int -> Int -> Bool
isSum n m = tri (m `div` 3) * 3
          + tri (m `div` 5) * 5
          - tri (m `div` 15) * 15
          == n

-- | The main entry point to the test suite.
main :: IO ()
main = hspec $ do
    describe "zeroToTen" $
        it "contains the numbers from 0 to 10" $
            L.zeroToTen == [0,1,2,3,4,5,6,7,8,9,10]
    describe "fourToEight" $
        it "contains the numbers from 4 to 8" $
            L.fourToEight == [4,5,6,7,8]
    describe "lowercase" $
        it "contains the lower-case characters from a to z" $
            L.lowercase == "abcdefghijklmnopqrstuvwxyz"
    describe "powersOfTwo" $
        it "contains the powers of two for 1 to 10" $
            L.powersOfTwo == [2,4,8,16,32,64,128,256,512,1024]
    describe "factorials" $
        it "contains the factorials for 1 to 10" $
            L.factorials == [1,2,6,24,120,720,5040,40320,362880,3628800]
    describe "coords" $ do
        it "contains 121 unique elements" $
            length (nub L.coords) == 121
        it "contains valid coordinates" $
            and [x >= 0 && x <= 10 && y >= 0 && y <= 10 | (x,y) <- L.coords]
    describe "noMoreThanFive" $ do
        it "contains 21 unique elements" $
            length (nub L.noMoreThanFive) == 21
        it "has no elements whose sections add up to more than 5" $
            and [x + y <= 5 && x + y >= 0 | (x,y) <- L.noMoreThanFive]
    describe "noMoreThanFive'" $ do
        it "contains 21 unique elements" $
            length (nub L.noMoreThanFive') == 21
        it "has no elements whose sections add up to more than 5" $
            and [x + y <= 5 && x + y >= 0 | (x,y) <- L.noMoreThanFive']
        it "has the same elements as noMoreThanFive in the same order" $ 
            L.noMoreThanFive == L.noMoreThanFive'
    describe "evens" $ do
        it "contains 51 unique elements" $
            length (nub L.evens) == 51
        it "only contains even numbers" $
            null (filter odd L.evens)
    describe "multiples" $ do
        prop "produces the right number of elements" $
            \(Positive n) -> length (L.multiples n) - 1 ==
                             n `div` 3 + n `div` 5 - n `div` 15
        prop "elements add up to the right values" $
            \(Positive n) -> isSum (sum $ L.multiples n) n

--------------------------------------------------------------------------------
