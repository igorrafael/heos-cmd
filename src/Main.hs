module Main where

import           Heos.Browse.PlayInput
import           Heos.Connection        (connect)
import           Heos.Player.GetPlayers
import           System.Environment     (getArgs, getProgName)

host _ = "192.168.0.19"
port _ = 1255

main :: IO ()
main = do
    args <- getArgs
    connection <- connect (host args) (port args)
    players <- getPlayers connection
    response <- getPlayerByName "HEOS 1" connection
    --response <- getPlayerByGid Nothing connection
    print $ show response
    inputChange <-case response of
      Just p -> playInput p "aux_in_1" connection
    print $ show inputChange
