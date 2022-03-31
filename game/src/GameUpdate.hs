module GameUpdate where

import Graphics.Gloss.Juicy
import Graphics.Gloss
import GameTypes
import GameInit

updateGame :: Time -> GameState -> GameState
updateGame dt state
  | collision dt (gamePlayer state) (gameObstacles state) = state {gameGameOver = True}
  | otherwise = state{
      gamePlayer = updatePlayer dt (gamePlayer state),
      --gameBackground = updateBackground dt (gameBackground state),
      gameScore = (gameScore state) + dt,
      gameObstacles = updateObstacles dt (gameObstacles state)
      }
 
updatePlayer :: Time -> Player -> Player
updatePlayer dt player = moveHorizontally dt (moveVertically dt player)
 
moveHorizontally :: Time -> Player -> Player
moveHorizontally dt player
  |(xLeft player) + dt * (xSpeed player) <= leftEdge = player
  |(xRight player) + dt * (xSpeed player) >= rightEdge = player
  | otherwise = player{
      xLeft = (xLeft player) + dt * (xSpeed player),
      xRight = (xRight player) + dt * (xSpeed player)
      }
 
moveVertically :: Time -> Player -> Player
moveVertically dt player
  |(yBottom player) + dt * (ySpeed player) <= bottomEdge = player
  |(yTop player) + dt * (ySpeed player) >= topEdge = player
  |otherwise = player{
      yBottom = (yBottom player) + dt * (ySpeed player),
      yTop = (yTop player) + dt * (ySpeed player)
      }
 
--l-left edge leftEdge
--r-right edge rightEdge
--b-bottom edge bottomEdge
--t-top edge topEdge
 
updateObstacles :: Time -> [Obstacle] ->[Obstacle]
updateObstacles _ [] = []
updateObstacles dt (ob:obs)
  |(xRight ob) < leftEdge = updateObstacles dt obs
  |otherwise = (dx ob) : updateObstacles dt obs
    where
        dx obstacle = obstacle {
            xLeft = (xLeft obstacle) + dt * (xSpeed obstacle),
            xRight = (xRight obstacle) + dt * (xSpeed obstacle)
            }
 
 
--updateBackground :: Time -> Background -> Background
--updateBackground dt bg = bg
--  {xLeft = (xLeft bg) + dt * (xSpeed bg)
--  ,xRight = (xRight bg) + dt * (xSpeed bg)}
 
collision :: Time -> Player -> [Obstacle] -> Bool
collision _ _ [] = False
collision dt player obstacles = or (map (collis dt player) (takeWhile onScreen obstacles))
  where onScreen obstacle = (xLeft obstacle) > rightEdge
--numElement - Number of elements on screen

--onScreen :: Int -> [Obstacle] -> [Obstacle]
--onScreen 0 _ = []
--onScreen n (ob:obs) = ob : onScreen $ (n-1) obs 

collis :: Time -> Player -> Obstacle -> Bool
collis dt player obstacle = or [(collisionHor dt player obstacle), (collisionVert dt player obstacle)]
collisionHor :: Time -> Player -> Obstacle -> Bool
collisionHor dt player obstacle
  |and [((xLeft obstacle)<=(xRight player)), ((xLeft obstacle)>=(xLeft player))] = True
  |and [((xRight obstacle)>=(xLeft player)), ((xRight obstacle)<=(xRight player))] = True
  |otherwise = False
collisionVert :: Time -> Player -> Obstacle -> Bool
collisionVert dt player obstacle
  |and [((yBottom obstacle)<=(yTop player)), ((yBottom obstacle)>=(yBottom player))] = True
  |and [((yTop obstacle)>=(yBottom player)), ((yTop obstacle)<=(yTop player))] = True
  |otherwise = False
