module GameHandle where

import Graphics.Gloss.Interface.IO.Game
import GameTypes
import GameInit
import System.Random
import GameUpdate

handleEvent :: Event -> GameState -> IO GameState
handleEvent (EventKey (MouseButton LeftButton) Down _ (x, y)) state
      | and[(gameGameOver state),
        x > 50, x < 350,
        y < (-120), y > (-170)]  = return (initGame (gameMoneyScore state) (mkStdGen 100) 
              (updateRecords (gameRecords state) (gameScore state)))
      | and [(gameGameOver state), (gameRecordsOver state)] = return state{ gameRecordsOver = False }
      | and[(gameGameOver state),
        x < 50, x > (-50),
        y < (-150), y > (-250)]  =  return state{ gameRecordsOver = True }
      | and [(gameGameOver state), 
        (gameMoneyScore state) >= moneyRevival,
        x < (-50), x > (-350),
        y < (-120), y > (-170)
        ] = return state {
          gameCollisPlayer = True, 
          gameMoneyScore = (gameMoneyScore state) - moneyRevival,
          gameGameOver = False,
          gameCollisSteps = 300}
      |otherwise = return state
handleEvent (EventKey (SpecialKey KeySpace) Down _ _) state
  | (gameGameOver state) = return (initGame (gameMoneyScore state) (mkStdGen 100) 
          (updateRecords (gameRecords state) (gameScore state)))
  | otherwise = return state
handleEvent (EventKey (SpecialKey KeyUp) Down _ _) state = return (makePlayerVert speed state)
handleEvent (EventKey (SpecialKey KeyUp) Up _ _) state = return (makePlayerVert 0 state)
handleEvent (EventKey (SpecialKey KeyDown) Down _ _) state = return (makePlayerVert (-speed) state)
handleEvent (EventKey (SpecialKey KeyDown) Up _ _) state = return (makePlayerVert 0 state)
handleEvent (EventKey (SpecialKey KeyLeft) Down _ _) state = return (makePlayerHor (-speed) state)
handleEvent (EventKey (SpecialKey KeyLeft) Up _ _) state = return (makePlayerHor 0 state)
handleEvent (EventKey (SpecialKey KeyRight) Down _ _) state = return (makePlayerHor speed state)
handleEvent (EventKey (SpecialKey KeyRight) Up _ _) state = return (makePlayerHor 0 state)
handleEvent _ state = return state

makePlayerVert :: Float -> GameState -> GameState
makePlayerVert sp state = state {gamePlayer = make (gamePlayer state)}
  where
    make player = player { ySpeed = sp }

makePlayerHor :: Float -> GameState -> GameState
makePlayerHor sp state = state {gamePlayer = make (gamePlayer state)}
  where
    make player = player { xSpeed = sp }