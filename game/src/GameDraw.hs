module GameDraw where

import Graphics.Gloss.Data.Vector
import Graphics.Gloss.Interface.Pure.Game
import GameTypes
import Graphics.Gloss.Data.Picture
import Graphics.Gloss.Juicy
import Graphics.Gloss


-- Отобразить игровое поле
drawGame :: Images -> GameState-> Picture
drawGame pic g = pictures
  [ drawBackground (picBackground pic) (gameBackground g),
   drawObstacles  (gameObstacles g),
   drawPlayer (picPlayer pic) (gamePlayer g),
   drawScore (gameScore g),
   drawGameOver (picGameOver pic) (gameGameOver g)
  ]

-- Отобразить все препятствия игрового поля, помещающиеся на экран
drawObstacles :: [Obstacle] -> Picture
drawObstacles = pictures . map drawObstacle . takeWhile onScreen
  where
    onScreen obstacle = (xLeft obstacle) > rightEdge


-- Нарисовать одно препятствие
drawObstacle :: Obstacle -> Picture 
drawObstacle ob = color (greyN 0.5) $ rectangleSolid 10 50

-- Нарисовать игрока
drawPlayer :: Picture -> Player -> Picture
drawPlayer image player = translate x y image
  where
    (x, y) = (xLeft player, yBottom player)

-- Нарисовать задний фон
drawBackground :: Picture -> Background -> Picture
drawBackground bg1 bg = translate x1 1 bg1
    where
      x1 = xLeft bg

-- Написать счет
drawScore :: Float -> Picture
drawScore a = text (show a)

drawGameOver :: Picture -> Bool -> Picture
drawGameOver image True = image
drawGameOver _ _ = blank