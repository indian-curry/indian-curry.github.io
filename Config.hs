module Config where
import Hakyll

-- | How many news item to show on the front page.
frontPageNewsItems :: Int
frontPageNewsItems = 10

feedConfig = FeedConfiguration
  { feedTitle       = "Indian Curry"
  , feedDescription = "Functional programming served red hot"
  , feedAuthorName  = "Indian curry"
  , feedAuthorEmail = ""
  , feedRoot        = "https://indian-curry.github.io/"
  }

-- | How many posts to show on atom feeds.
postsOnFeed :: Int
postsOnFeed = 100
