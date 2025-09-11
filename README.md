# My dotfiles

This directory contains the dotfiles for my system

## Requirements

Ensure you have the following installed on your system

### Git

```
brew install git
```

### Stow

```
brew install stow
```

### WezTerm

```
brew install --cask wezterm
```

### Nerd Font

```
brew install font-jetbrains-mono-nerd-font
```

### Zoxide

```
brew install zoxide
```

### Eza

```
brew install eza
```

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

