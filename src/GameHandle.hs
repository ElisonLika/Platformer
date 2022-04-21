module GameHandle where

import Graphics.Gloss.Interface.Pure.Game
import GameTypes
import GameInit
import System.Random
import GameUpdate

handleEvent :: Event -> GameState -> GameState
handleEvent (EventKey (MouseButton LeftButton) Down _ (x, y)) state
      | and[(gameGameOver state),
        x > 50, x < 350,
        y < (-120), y > (-170)]  = initGame (gameMoneyScore state) (mkStdGen 100) 
          (updateRecords (gameRecords state) (gameScore state))
      | and [(gameGameOver state), (gameRecordsOver state)] = state{ gameRecordsOver = False }
      | and[(gameGameOver state),
        x < 50, x > (-50),
        y < (-150), y > (-250)]  =  state{ gameRecordsOver = True }
      | and [(gameGameOver state), 
        (gameMoneyScore state) >= moneyRevival,
        x < (-50), x > (-350),
        y < (-120), y > (-170)
        ] = state {
          gameCollisPlayer = True, 
          gameMoneyScore = (gameMoneyScore state) - moneyRevival,
          gameGameOver = False,
          gameCollisSteps = 300}
      |otherwise = state
handleEvent (EventKey (SpecialKey KeySpace) Down _ _) state
  | (gameGameOver state) = initGame (gameMoneyScore state) (mkStdGen 100) 
          (updateRecords (gameRecords state) (gameScore state))
  | otherwise = state
handleEvent (EventKey (SpecialKey KeyUp) Down _ _) state = makePlayerVert speed state
handleEvent (EventKey (SpecialKey KeyUp) Up _ _) state = makePlayerVert 0 state
handleEvent (EventKey (SpecialKey KeyDown) Down _ _) state = makePlayerVert (-speed) state
handleEvent (EventKey (SpecialKey KeyDown) Up _ _) state = makePlayerVert 0 state
handleEvent (EventKey (SpecialKey KeyLeft) Down _ _) state = makePlayerHor (-speed) state
handleEvent (EventKey (SpecialKey KeyLeft) Up _ _) state = makePlayerHor 0 state
handleEvent (EventKey (SpecialKey KeyRight) Down _ _) state = makePlayerHor speed state
handleEvent (EventKey (SpecialKey KeyRight) Up _ _) state = makePlayerHor 0 state
handleEvent _ state = state
 

makePlayerVert :: Float -> GameState -> GameState
makePlayerVert sp state = state {gamePlayer = make (gamePlayer state)}
  where
    make player = player { ySpeed = sp }

makePlayerHor :: Float -> GameState -> GameState
makePlayerHor sp state = state {gamePlayer = make (gamePlayer state)}
  where
    make player = player { xSpeed = sp }