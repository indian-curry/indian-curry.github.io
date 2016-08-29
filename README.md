# Website of [Indian Curry]


This is the hakyll source code that powers the webiste
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
[install haskell stack]: <https://docs.haskellstack.org/en/stable/README/>
[repo]: <https://github.com/indian-curry/indian-curry.github.io>
