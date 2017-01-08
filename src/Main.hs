module Main where

import           Heos.Connection    (connect, get)
import           System.Environment (getArgs, getProgName)

host _ = "192.168.0.19"
port _ = 1255

main :: IO ()
main = do
    args <- getArgs
    putStrLn "Hi"
    connection <- connect (host args) (port args)
    response <- get connection "heos://player/get_players"
    putStrLn response
