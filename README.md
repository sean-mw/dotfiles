# dotfiles

Minimal, rebuilt from scratch. See [PLAN.md](PLAN.md).

```sh
git clone git@github.com:sean-mw/dotfiles.git ~/dotfiles
cd ~/dotfiles
brew bundle
stow zsh git tmux nvim wezterm claude
```

Machine-specific settings go in `~/.zshrc.local` (untracked).
