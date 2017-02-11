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

import Config
import Website.Utils


categories :: [FilePath]
categories = ["posts", "jobs", "events"]

newsRules :: Rules ()
newsRules = match allNewsPat $ do
  route cleanRoute
  compile $ newsCompiler

  -- Make the list of news.
  listOfNewsRule "Archive" "news" allNewsPat


newsCompiler :: Compiler (Item String)
newsCompiler = pandocCompiler  >>= saveSnapshot "content"
               >>= postProcessTemplates newsCxt [ "templates/post.html"
                                                , "templates/default.html"
                                                , "templates/wrapper.html"
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

rootPageNews = listField "news" newsCxt $ fmap (take frontPageNewsItems) $ loadAll allNewsPat >>= recentFirst
---------------------- Various patterns -------------------------------

categoryPat :: FilePath -> Pattern
categoryPat fp = fromString $ "news" </> fp </> "*"

allNewsPat :: Pattern
allNewsPat = foldl1 (.||.) $ categoryPat <$> categories

-- | Generating feeds.
compileFeeds :: Compiler [Item String]
compileFeeds =   loadAllSnapshots allNewsPat "content"
             >>= fmap (take postsOnFeed) . recentFirst
             >>= mapM relativizeUrls

----------------------- Pattern based ---------------------------------

listOfNewsRule :: String -> Identifier -> Pattern -> Rules ()
listOfNewsRule title  ident pat = do

  -- Build the listing page.
  create [ident] $ do
    route cleanRoute
    let cxt = constField "title" title <> listings <> defaultContext
      in compile $ makeItem ""
                 >>= loadAndApplyTemplate "templates/news-list.html" cxt
                 >>= postProcess cxt

    let feedContext = newsCxt <> bodyField "description" in do
      create ["news/feeds/atom.xml"] $ do
        route idRoute
        compile $ compileFeeds >>= renderAtom feedConfig feedContext

  where listings = newsField "news" pat
