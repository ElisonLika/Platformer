module Game where

import Graphics.Gloss.Interface.Pure.Game
import System.Random
import Graphics.Gloss.Juicy
import Graphics.Gloss
import GameTypes
import GameDraw
import GameInit
import GameHandle
import GameUpdate
------------------------------
-- Main function for this app.
------------------------------

loadImages :: IO Images
loadImages = do
  Just pers   <- loadJuicyPNG "src/person.png"
  Just bgrd   <- loadJuicyPNG "src/bg.png"
  Just gover  <- loadJuicyPNG "src/gameover.png"
  return Images
    { picPlayer   = scale 3 3 pers
    , picBackground =  bgrd 
    , picGameOver = scale 3 3 gover
    }

-- Run game. This is the ONLY unpure function.
runGame :: Images -> IO ()
runGame images= do
  g <- newStdGen
  play display bgColor fps (initGame g) (drawGame images) handleEvent updateGame
  where
    display = InWindow "Game" (screenWidth, screenHeight) (200, 200)
    bgColor = white
    fps     = 60
