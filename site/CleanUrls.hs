module CleanUrls (cleanRoute, cleanIndexUrls, cleanIndexHtmls) where

import Data.List (isSuffixOf)
import System.FilePath.Posix  (takeDirectory, takeBaseName, (</>))
import Hakyll
import Debug.Trace

-- https://www.rohanjain.in/hakyll-clean-urls/

cleanRoute :: Routes
cleanRoute = customRoute createIndexRoute
  where
    createIndexRoute ident = takeDirectory p </> takeBaseName p </> "index.html"
                            where p = toFilePath ident

cleanIndexUrls :: Item String -> Compiler (Item String)
cleanIndexUrls = return . fmap (withUrls cleanIndex)

cleanIndexHtmls :: Item String -> Compiler (Item String)
cleanIndexHtmls = return . fmap (replaceAll pattern replacement)
    where
      pattern = "/index.html"
      replacement = const "/"

cleanIndex :: String -> String
cleanIndex url
    | idx `isSuffixOf` url = trace ("cut:" ++ url) $ take (length url - length idx) url
    | otherwise            = trace ("otherwise: " ++ url) $ url
  where idx = "index.html"
