{-# LANGUAGE OverloadedStrings #-}

import           Data.Monoid             ( mappend, (<>))
import           System.FilePath
import           Hakyll

import           Website.Utils
import           Website.News

config :: Configuration
config = defaultConfiguration { deployCommand = "./scripts/deploy.sh" }

--------------------------------------------------------------------------------
main :: IO ()
main = hakyllWith config $ do
  match "templates/*" $ compile templateCompiler

  match "images/*" $ do
    route   idRoute
    compile copyFileCompiler
  
  match "css/*" $ do
    route   idRoute
    compile compressCssCompiler

  match (fromList ["about.rst", "contact.markdown"]) $ do
    route   cleanRoute
    compile stdCompiler

  newsRules
    
  match "index.html" $ do
    route   idRoute
    let cxt = allNewsField <> constField "title" "" <> defaultContext
      in compile $ getResourceBody
         >>= applyAsTemplate cxt
         >>= postProcess cxt
{-

    match "archive/index.md" $ do
        route $ setExtension "html"
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let archiveCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Archives"            `mappend`
                    defaultContext

            getResourceBody
                >>= applyAsTemplate archiveCtx
                >>= renderPandoc
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= fixUrls

    match "index.md" $ do
        route $ setExtension ".html"
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let indexCtx =
                    listField "posts" postCtx (return posts)
                    <> constField "title" ""
                    <> defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= renderPandoc
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= fixUrls

    
-}

--------------------------------------------------------------------------------
