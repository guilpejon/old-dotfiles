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

## Demo

TODO

## Features

TODO


## Installation

To get started, make sure you have [curl](https://github.com/curl/curl) and [git](https://git-scm.com/downloads) installed.

1. Tell git who you are
```bash
git config -f ~/.gitlocal user.email "email@yoursite.com"
git config -f ~/.gitlocal user.name "Name Lastname"
```

2. Run the install script

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/guilpejon/dotfiles/main/gldf.sh)"
```

> **gldf** is installed by default in your `$HOME` directory.

## Usage

Just run **`gldf`** anywhere in your terminal.

```bash
gldf
```
Leave the rest to it.

## What else 👀

gldf exports 2 variables in your default shell config (`bashrc`, `zshrc` etc):

1. `DOT_DEST`: used for finding the location of dotfiles repository in your local system.
2. `DOT_REPO`: the url to the remote dotfile repo.

You can change these manually if any one of the info changes.

## Author

**Guilherme Pejon** ([Web](https://guilpejon.me) | [Twitter](https://twitter.com/guilpejon))
