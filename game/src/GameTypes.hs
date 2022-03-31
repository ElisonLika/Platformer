module GameTypes where
import Graphics.Gloss.Data.Vector
import Graphics.Gloss.Geometry.Line
import Graphics.Gloss.Interface.Pure.Game
import Graphics.Gloss

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
speed = 200

numElement :: Int
numElement = 10

leftEdge :: Float
leftEdge = - fromIntegral screenWidth / 2
rightEdge :: Float
rightEdge = fromIntegral screenWidth / 2
bottomEdge :: Float
bottomEdge = - fromIntegral screenHeight / 2
topEdge :: Float
topEdge = fromIntegral screenHeight / 2

screenWidth :: Int
screenWidth = 700

screenHeight :: Int
screenHeight = 450

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

