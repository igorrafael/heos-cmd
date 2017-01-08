module Main where

import           Heos.Connection        (connect)
import           Heos.Player.GetPlayers
import           System.Environment     (getArgs, getProgName)

host _ = "192.168.0.19"
port _ = 1255

main :: IO ()
main = do
    args <- getArgs
    connection <- connect (host args) (port args)
    --response <- getPlayers connection
    response <- getPlayerByName "HEOS 1" connection
    print $ show response
