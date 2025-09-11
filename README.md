# My dotfiles

This directory contains the dotfiles for my system

## Requirements

Ensure you have [Homebrew](https://brew.sh) installed on your system


## Installation

First, check out the dotfiles repo in your $HOME directory using git

```
$ git clone git@github.com:sean-mw/dotfiles.git
$ cd dotfiles
```

then use GNU stow to create symlinks

```
$ stow .
```

finally, install all required packages specified in the Brewfile

```
brew bundle
```

