# Website of [Indian Curry]

[![Build Staus][travis-status]][travis-indian-curry]
[![In Progress][waffle-inprogress]][waffle-indian-curry]

This is the hakyll source code that powers the website
<https://indian-curry.github.io>. While the master branch contains the
generated files, the actual source resides in the develop branch.


## Building the website

The website uses the [Hakyll] static website generator. We recommend
using [stack] to build the site.

* [Install haskell stack]

* Fork [the repository on github][repo].

* Clone locally and work with the contents.

```bash

git clone git@github.com/your-user-name/indian-curry.github.io

stack build website         # build hakyll executable
stack exec  website build   # should build the site
stack exec  website watch   # run preview server on localhost:8000
stack exec  website check   # check for broken links
git checkout -b topic       # Create a topic branch for developing.

```
* When done push your topic branch and send pull request.

```bash
git push origin -u topic # and send pull request from topic

```

## Unconventional branch structure.

This repository has two branches the `master` and `develop`. Since
this repository servers also as github pages for our website, the
contents of the master branch are the raw html/css/media files are not
of interest for the developer.  The actual source for the website
resides in the `develop` branch. For more details see the tutorial
<https://jaspervdj.be/hakyll/tutorials/github-pages-tutorial.html>.



[indian curry]: <https://indian-curry.github.io> "Indian curry homepage"
[install haskell stack]: <https://docs.haskellstack.org/en/stable/README/> "Install haskell stack"
[stack]: <https://docs.haskellstack.org/en/stable/README/> "Haskell Stack"
[hakyll]: <https://jaspervdj.be/hakyll/> "Hakyll website generator"
[repo]: <https://github.com/indian-curry/indian-curry.github.io>

[waffle-indian-curry]:   <http://waffle.io/indian-curry/indian-curry.github.io>
[waffle-inprogress]: <https://badge.waffle.io/indian-curry/indian-curry.github.io.svg?label=waffle%3Ain%20progress&title=In%20Progress>
[travis-status]: <https://travis-ci.org/indian-curry/indian-curry.github.io.svg?branch=develop> "Build status"
[travis-indian-curry]: <https://travis-ci.org/indian-curry/indian-curry.github.io> "Build status"

