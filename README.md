<h1 align="center">GuiLDotFiles</h1>

<div align="center">
  <img src="https://user-images.githubusercontent.com/871362/67146077-9bb93f80-f25d-11e9-9119-dbd83b6b4b62.png" />
  <p align="center"><i>WIP since 2012</i></p>
</div>

<p align="center">
  <a href="https://github.com/Bhupesh-V/dotman/blob/master/LICENSE">
    <img alt="License: MIT" src="https://img.shields.io/github/license/Bhupesh-V/dotman" />
  </a>
  <a href="">
    <img alt="platform: linux and macos" src="https://img.shields.io/badge/platform-GNU/Linux %7C MacOS-blue">
  </a>
</p>

# Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Commands](#commands)
- [Support](#support)
- [Author](#author)

## Installation

To get started, make sure you have [curl](https://github.com/curl/curl) and [git](https://git-scm.com/downloads) installed.

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/guilpejon/dotfiles/main/gldf.sh)"
```
> **gldf** is installed by default in your `$HOME` directory.

### MacOS

If you are using macOS, after installation open iterm2 and press `COMMAND+i`. Then, go to Colors -> Color Presets and select the "Gruvbox Dark" theme. 

## Usage

Just run **`gldf`** anywhere in your terminal.

```bash
gldf
```

Leave the rest to it.

## Commands

## VIM
```ruby
  Shift + K # search for word under the cursor
  \ <word> <folder> # search for <word> in <folder>(optional)

  #TODO, continue
```

## ZSH
```ruby
  # git flow aliases for staging and production environments
  deploy='git checkout master && git pull origin master && git push heroku master --no-verify'
  sdeploy='git checkout release && git pull origin release && git push staging release:master --no-verify'
  upall='git checkout master && git pull origin master; git checkout develop && git pull origin develop; git checkout release && git pull origin release'

  # heroku aliases
  pc="heroku run rails console --remote heroku"
  sc="heroku run rails console --remote staging"

  # ruby
  rdm='rake db:migrate'
  c='rails c'

  # processes
  ka9='killall -9'
  k9='kill -9'

  # mimic vim functions
  :q='exit'

  # listing
  la='ls -A'
  l='ls -CF'
  ll='ls -alh --color=auto'
  ls='ls --color=auto'
```

## Git Aliases
```ruby
  gs='git status'
  gstsh='git stash'
  gst='git stash'
  gsp='git stash pop'
  gsa='git stash apply'
  gsh='git show'
  gshw='git show'
  gshow='git show'
  gi='vim .gitignore'
  gcm='git ci -m'
  gcim='git ci -m'
  gps='git push'
  gpl='git pull'
  gci='git ci'
  gco='git co'
  gcp='git cp'
  ga='git add -A'
  gap='git add -p'
  guns='git unstage'
  gunc='git uncommit'
  gm='git merge'
  gms='git merge --squash'
  gam='git amend --reset-author'
  grv='git remote -v'
  grr='git remote rm'
  grad='git remote add'
  gr='git rebase'
  gra='git rebase --abort'
  ggrc='git rebase --continue'
  gbi='git rebase --interactive'
  gl='git l'
  glg='git l'
  glog='git l'
  co='git co'
  gf='git fetch'
  gfp='git fetch --prune'
  gfa='git fetch --all'
  gfap='git fetch --all --prune'
  gfch='git fetch'
  gd='git diff'
  gb='git b'

  # add
  a = add                           # add
  chunkyadd = add --patch           # stage commits chunk by chunk

  # via http://blog.apiaxle.com/post/handy-git-tips-to-stop-you-getting-fired/
  snapshot = !git stash save "snapshot: $(date)" && git stash apply "stash@{0}"
  snapshots = !git stash list --grep snapshot

  #via http://stackoverflow.com/questions/5188320/how-can-i-get-a-list-of-git-branches-ordered-by-most-recent-commit
  recent-branches = !git for-each-ref --count=15 --sort=-committerdate refs/heads/ --format='%(refname:short)'

  # branch
  b = branch -v                     # branch (verbose)

  # commit
  c = commit -m                     # commit with message
  ca = commit -am                   # commit all with message
  ci = commit                       # commit
  amend = commit --amend            # ammend your last commit
  ammend = commit --amend           # ammend your last commit

  # checkout
  co = checkout                     # checkout
  nb = checkout -b                  # create and switch to a new branch (mnemonic: "git new branch branchname...")

  # cherry-pick
  cp = cherry-pick -x               # grab a change from a branch

  # diff
  d = diff                          # diff unstaged changes
  dc = diff --cached                # diff staged changes
  last = diff HEAD^                 # diff last committed change

  # log
  l = log --graph --date=short
  changes = log --pretty=format:\"%h %cr %cn %Cgreen%s%Creset\" --name-status
  short = log --pretty=format:\"%h %cr %cn %Cgreen%s%Creset\"
  simple = log --pretty=format:\" * %s\"
  shortnocolor = log --pretty=format:\"%h %cr %cn %s\"

  # pull
  pl = pull                         # pull

  # push
  ps = push                         # push

  # rebase
  rc = rebase --continue            # continue rebase
  rs = rebase --skip                # skip rebase

  # remote
  r = remote -v                     # show remotes (verbose)

  # reset
  unstage = reset HEAD              # remove files from index (tracking)
  uncommit = reset --soft HEAD^     # go back before last commit, with files in uncommitted state
  filelog = log -u                  # show changes to a file
  mt = mergetool                    # fire up the merge tool

  # stash
  ss = stash                        # stash changes
  sl = stash list                   # list stashes
  sa = stash apply                  # apply stash (restore changes)
  sd = stash drop                   # drop stashes (destory changes)

  # status
  s = status                        # status
  st = status                       # status
  stat = status                     # status

  # tag
  t = tag -n                        # show tags with <n> lines of each tag message

  # svn helpers
  svnr = svn rebase
  svnd = svn dcommit
  svnl = svn log --oneline --show-commit
```

# Support

If you find any problems or bugs, please open a new [issue](https://github.com/guilpejon/gldf/issues).


## Author

**Guilherme Pejon** ([Web](https://guilpejon.me) | [Twitter](https://twitter.com/guilpejon))
