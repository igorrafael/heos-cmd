module Heos.Request (Request(..),Parameter(..)) where

data Request = Request String [Parameter]

instance Show Request where
  show (Request url [])     = url
  show (Request url params) = url ++ "?" ++ foldl1 (\a b -> a++"&"++b) (map show params)

data Parameter = Parameter String String

instance Show Parameter where
  show (Parameter name value) = name ++ "=" ++ value
