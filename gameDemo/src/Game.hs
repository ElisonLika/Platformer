module Game where

import Graphics.Gloss.Interface.Pure.Game
import Graphics.Gloss.Juicy
import GameTypes
import GameDraw
import GameInit
import GameHandle
import GameUpdate
import System.Random
-----------------------------
-- Main function for this app.
------------------------------

loadImages :: IO Images
loadImages = do
  Just bgrd   <- loadJuicy "src/bg.png"
  Just pers   <- loadJuicy "src/pers.png"
  Just gover   <- loadJuicy "src/gameover.png"
  return Images
    {picBackground = bgrd,
    picGameOver = gover,
    picPlayer = pers
    }

-- Run game. This is the ONLY unpure function.
runGame :: Images -> IO ()
runGame images= do
  g <- newStdGen
  play display bgColor fps (initGame g) (drawGame images) handleEvent updateGame
  where
    display = InWindow "Game" (screenWidth, screenHeight) (0,0)
    bgColor = black
    fps     = 60
