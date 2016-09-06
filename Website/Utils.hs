-- | Some Hakyll utilities.
module Website.Utils
       ( fixUrls, cleanRoute
       ) where


import Control.Monad           ( (>=>)      )
import Data.List               ( isSuffixOf )

import Hakyll
import System.FilePath

-- | Takes a route of the form foo/bar/biz.html to foo/bar/biz/index.html. The resulting
-- url is cleaner and hence we prefer this.
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
    | idx `isSuffixOf` url = take (length url - length idx) url
    | otherwise            = url
  where idx = "index.html"

-- | Fixes urls. Firstly it relativises urls and converts any reference to @foo/bar/biz/index.html@ to
-- @foo/bar/biz@.
fixUrls :: Item String -> Compiler (Item String)
fixUrls = relativizeUrls >=> cleanIndexUrls
