{-# LANGUAGE OverloadedStrings #-}
-- | Module to handle the news items.

module Website.News
       ( newsCxt, newsField, allNewsField
       , newsRules
       ) where

import Data.Monoid    ( (<>) )
import Data.String
import Hakyll
import Prelude
import System.FilePath

import Website.Utils


categories :: [FilePath]
categories = ["posts", "jobs", "events"]


newsRules = match allNewsPat $ do
  route cleanRoute
  compile $ newsCompiler

       
newsCompiler :: Compiler (Item String)
newsCompiler = pandocCompiler
               >>= postProcessTemplates newsCxt [ "templates/post.html"
                                                , "templates/default.html"
                                                ]

-- | News item context
newsCxt :: Context String
newsCxt = 
    dateField "date" "%B %e, %Y"
    <> dateField "month" "%b"
    <> dateField "year"  "%Y"
    <> dateField "day"   "%a"
    <> dateField "dayofmonth" "%e"
    <> teaserField "teaser" "content"
    <> defaultContext

----------------------- Some fields --------------------------------

-- | A field item that generates a list of posts.
newsField :: String -> Pattern -> Context a
newsField fName pat = listField fName newsCxt $ loadAll pat >>= recentFirst

allNewsField :: Context a
allNewsField = newsField "news" allNewsPat

---------------------- Various patterns -------------------------------

categoryPat :: FilePath -> Pattern
categoryPat fp = fromString $ "news" </> fp </> "*"

allNewsPat :: Pattern
allNewsPat = foldl1 (.||.) $ categoryPat <$> categories


