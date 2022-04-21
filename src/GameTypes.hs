module GameTypes where

import Graphics.Gloss.Interface.Pure.Game

type Time = Float
type Records=[Int]

data Square = Square{
    xLeft :: Float
    ,xRight :: Float
    ,yBottom :: Float
    ,yTop :: Float
    ,xSpeed :: Float
    ,ySpeed :: Float
    }
type Player = Square
type Obstacle = Square
type Background = Square
type Money = Square

data GameState = GameState{
    gameObstacles :: [Obstacle]
    ,gamePlayer :: Player
    ,gameBackground :: Background
    ,gameScore :: Int
    ,gameGameOver :: Bool
    ,gameRecordsOver :: Bool
    ,gameRecords :: Records
    ,gameMoneyScore :: Int
    ,gameMoney :: [Money]
    ,gameCollisPlayer :: Bool
    ,gameCollisSteps :: Int
    }

data Images = Images{
    --picObstacle :: Picture
    picPlayer :: Picture
    ,picPlayerCollis :: Picture
    ,picBackground :: Picture
    ,picGameOver :: Picture
    ,picBgRecords :: Picture
    ,picMoney :: Picture
    }

speed :: Float
speed = 500
speedPlat :: Float
speedPlat = 550
speedMoney :: Float
speedMoney = 600


numbRecords :: Int
numbRecords = 10
numb :: [Int]
numb = [1,2,3,4,5,6,7,8,9,10,11]
numElement :: Int
numElement = 10

leftEdge :: Float
leftEdge = - (fromIntegral screenWidth)/2
rightEdge :: Float
rightEdge = (fromIntegral screenWidth)/2
bottomEdge :: Float
bottomEdge = - (fromIntegral screenHeight)/2
topEdge :: Float
topEdge = (fromIntegral screenHeight)/2

screenWidth :: Int
screenWidth = 1070

screenHeight :: Int
screenHeight = 550

platformWidth :: Float
platformWidth = 20
platformHeight :: Float
platformHeight = 100
defaultOffset :: Float
defaultOffset = 200

moneyWidth :: Float
moneyWidth = 40
moneyHeight :: Float
moneyHeight = 40
moneyOffset :: Float
moneyOffset = 600

rRecords :: Records
rRecords = [35555,2500,1500,0,0,0,0,0,0,0]

moneyRevival :: Int
moneyRevival = 10

recordsPath :: FilePath
recordsPath = "records.txt"

obstacleHeight :: (Float, Float)
obstacleHeight = (-w, w)
  where
    w = (fromIntegral screenHeight - platformHeight) / 2

