module GameInit where

import Graphics.Gloss.Interface.Pure.Game
import GameTypes
import System.Random

-- Инициализация игрового поля
initGame :: Int -> StdGen -> Records -> GameState
initGame m g records = GameState
 {gameObstacles = absoluteObstacles 300 platformWidth defaultOffset (initObstacles g),
  gamePlayer = initPlayer,
  gameScore  = 0,
  gameBackground = initBackground,
  gameGameOver = False,
  gameRecordsOver = False,
  gameRecords = records,
  gameMoneyScore = m,
  gameMoney = absoluteObstacles 500 moneyWidth moneyOffset (initMoney g),
  gameCollisPlayer = False,
  gameCollisSteps = 0,
}
 
-- Инициализирование начальное состояние игрока
initPlayer :: Player
initPlayer = Square
  { xLeft = -500,
    yBottom = 0,
    xRight = -350,
    yTop = 83,
    xSpeed = 0,
    ySpeed = 0
  }

--  Создание бесконечный списка препятствий /подправить
absoluteObstacles :: Float -> Float -> Float -> [Square] -> [Square]
absoluteObstacles _ _ _ [] = []
absoluteObstacles x width offset (ob:obs) = ob{
  xLeft = x - width, 
  xRight = x
  } : absoluteObstacles (x + offset) width offset obs

-- Инициализирование случайного бесконечного списка препятствий для игрового поля
initObstacles :: StdGen -> [Obstacle]
initObstacles g = map initObstacle (randomRs obstacleHeight g)

-- Инициализация одной платформы
initObstacle :: Float -> Obstacle
initObstacle h = Square
  { xLeft = 0,
    xRight =0,
    yBottom = h - platformHeight/2,
    yTop = h + platformHeight/2,
    xSpeed = -speedPlat,
    ySpeed = 0
  }

initMoney :: StdGen -> [Money]
initMoney g = map initOneMoney (randomRs obstacleHeight g)

initOneMoney :: Float -> Money
initOneMoney h = Square
  { xLeft = 0,
    xRight =0,
    yBottom = h - moneyHeight/2,
    yTop = h + moneyHeight/2,
    xSpeed = -speedMoney,
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