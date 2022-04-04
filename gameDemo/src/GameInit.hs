module GameInit where

import System.Random
import Graphics.Gloss.Interface.Pure.Game
import GameTypes
-- Инициализация игрового поля
initGame :: StdGen -> GameState
initGame g = GameState
 {gameObstacles = absoluteObstacles (initObstacles g),
  gamePlayer = initPlayer,
  gameScore  = 0,
  gameBackground = initBackground,
  gameGameOver = False
}

--  Создание бесконечный списка препятствий /подправить
absoluteObstacles :: [Obstacle] -> [Obstacle]
absoluteObstacles [] = []
absoluteObstacles (ob:obs) = ob{
  xLeft = (xLeft ob) - defaultOffset, 
  xRight = (xRight ob) - defaultOffset
  } : absoluteObstacles obs
 
-- Инициализирование начальное состояние игрока
initPlayer :: Player
initPlayer = Square
  { xLeft = -995,
    yBottom = 0,
    xRight = -715,
    yTop = 115,
    xSpeed = 0,
    ySpeed = 0
  }

-- Инициализирование случайного бесконечного списка препятствий для игрового поля
initObstacles :: StdGen -> [Obstacle]
initObstacles g = map initObstacle (randomRs obstacleHeight g)

-- Инициализация одной платформы
initObstacle :: Float -> Obstacle
initObstacle h = Square
  { xLeft = 5000 - platformWidth,
    yBottom = h - platformHeight/2,
    xRight = 5000,
    yTop = h + platformHeight/2,
    xSpeed = -speedPlat,
    ySpeed = 0
  }


initBackground :: Background
initBackground = Square{
    xLeft = -(fromIntegral screenWidth / 2),
    yBottom = -(fromIntegral screenHeight / 2),
    xRight = (fromIntegral screenWidth / 2),
    yTop = (fromIntegral screenHeight / 2),
    xSpeed = 0,
    ySpeed = 0
  }
-- N = 5000 - надо подобрать
-- | Инициализировать конец игры.
initGameOver :: Point
initGameOver = (0, 0)