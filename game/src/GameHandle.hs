module GameHandle where

import System.Random
import Graphics.Gloss.Interface.Pure.Game
import Graphics.Gloss.Juicy
import Graphics.Gloss
import GameTypes
import GameInit
import GameUpdate

handleEvent :: Event -> GameState -> GameState
handleEvent (EventKey (SpecialKey KeyUp) Down _ _) state = makePlayerUp state
handleEvent (EventKey (SpecialKey KeyUp) Up _ _) state = makePlayerStopVert state
handleEvent (EventKey (SpecialKey KeyDown) Down _ _) state = makePlayerDown state
handleEvent (EventKey (SpecialKey KeyDown) Up _ _) state = makePlayerStopVert state
handleEvent (EventKey (SpecialKey KeyLeft) Down _ _) state = makePlayerUp state
handleEvent (EventKey (SpecialKey KeyLeft) Up _ _) state = makePlayerStopHor state
handleEvent (EventKey (SpecialKey KeyRight) Down _ _) state = makePlayerUp state
handleEvent (EventKey (SpecialKey KeyRight) Up _ _) state = makePlayerStopHor state
handleEvent (EventKey (SpecialKey KeySpace) Down _ _) state
      | (gameGameOver state)  = initGame (mkStdGen 11)
      | otherwise = state
handleEvent _ state = state
 
 
makePlayerUp :: GameState -> GameState
makePlayerUp state = state {gamePlayer = make (gamePlayer state)}
  where
    make player = player { ySpeed = speed }
makePlayerDown :: GameState -> GameState
makePlayerDown state = state {gamePlayer = make (gamePlayer state)}
  where
    make player = player { ySpeed = -speed }
makePlayerForward :: GameState -> GameState
makePlayerForward state = state {gamePlayer = make (gamePlayer state)}
  where
    make player = player { xSpeed = speed }
makePlayerBack :: GameState -> GameState
makePlayerBack state = state {gamePlayer = make (gamePlayer state)}
  where
    make player = player { xSpeed = -speed }
makePlayerStopVert :: GameState -> GameState
makePlayerStopVert state = state {gamePlayer = make (gamePlayer state)}
  where
    make player = player { ySpeed = 0}
makePlayerStopHor :: GameState -> GameState
makePlayerStopHor state = state {gamePlayer = make (gamePlayer state)}
  where
    make player = player { xSpeed = 0}