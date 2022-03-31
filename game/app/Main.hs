module Main where

import Game
main :: IO ()
main = do
    images <- loadImages
    runGame images
