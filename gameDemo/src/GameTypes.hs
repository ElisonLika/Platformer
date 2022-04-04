module GameTypes where

import Graphics.Gloss.Interface.Pure.Game

type Time = Float

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

data GameState = GameState{
    gameObstacles :: [Obstacle]
    ,gamePlayer :: Player
    ,gameBackground :: Background
    ,gameScore :: Float
    ,gameGameOver :: Bool
    }

data Images = Images{
    --picObstacle :: Picture
    picPlayer :: Picture
    ,picBackground :: Picture
    ,picGameOver :: Picture
    }

speed :: Float
speed = 500

speedPlat :: Float
speedPlat = 600

numElement :: Int
numElement = 10

leftEdge :: Float
leftEdge = - (fromIntegral screenWidth)
rightEdge :: Float
rightEdge = (fromIntegral screenWidth)
bottomEdge :: Float
bottomEdge = - (fromIntegral screenHeight)
topEdge :: Float
topEdge = (fromIntegral screenHeight)

screenWidth :: Int
screenWidth = 1070

screenHeight :: Int
screenHeight = 550

platformWidth :: Float
platformWidth = 20
platformHeight :: Float
platformHeight = 120
defaultOffset :: Float
defaultOffset = 200

obstacleHeight :: (Float, Float)
obstacleHeight = (-w, w)
  where
    w = (fromIntegral screenHeight - platformHeight) / 2

