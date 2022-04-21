module Main where

import Game
import GameTypes
main :: IO ()
main = do
    images <- loadImages
    str <- readFile recordsPath
    case images of
      (Just bgrd, Just pers, Just persCollis, Just gover, Just money, Just bgRec) ->  
        case loadRecords str of
          Nothing -> putStrLn "Wrong records"
          Just records -> do 
            runGame records (imag bgrd pers persCollis gover money bgRec) 
            writeFile recordsPath (show rRecords)
      _ -> putStrLn "Pictures error"
