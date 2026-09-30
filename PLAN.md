# Dotfiles rebuild plan

Principle: **nothing goes in until I miss it.** When something is annoying, add the
smallest fix, commit it with a message that says *why*.

## Layout

One GNU Stow package per tool. `stow <pkg>` symlinks its contents into `$HOME`.

```
dotfiles/
├── Brewfile            # only tools that are actually used
├── PLAN.md
├── README.md
├── zsh/.zshrc
├── git/.gitconfig
├── git/.config/git/ignore
├── tmux/.tmux.conf
├── nvim/.config/nvim/{init.lua,nvim-pack-lock.json}
├── wezterm/.wezterm.lua
├── (later) bootstrap.sh
├── (later) claude/plugins
├── claude/.claude/{CLAUDE.md,settings.json}
└── (later) claude/.claude/skills/
```

Why per-package rather than `stow .`: each tool can be added, removed or tested on its own
(`stow -D tmux`), and the repo tree shows what's managed.

Machine-specific or secret settings go in `~/.zshrc.local`, which is untracked.

## Phase 0: scaffold (done)

- Old repo moved to `~/dotfiles-legacy` (history, remote and uncommitted changes intact)
- New `~/dotfiles` with `zsh`, `git`, `tmux` (core bindings, no plugins), `nvim` 0.12 (system clipboard, nvim-tree via built-in `vim.pack`)
- Minimal `.zshrc`: PATH, editor, history, completion, vi keys, plain prompt
- `openjdk@21` PATH moved to `~/.zshrc.local`

## Phase 1: live with it for a week, re-add only what hurts

Candidates from legacy, **not** carried over. Add each back only if missed:

| Legacy                           | Question to ask                                        |
|----------------------------------|--------------------------------------------------------|
| zinit + p10k + 3 zsh plugins     | Is a plain prompt fine? If not, try `starship` (one binary, no plugin manager) |
| zoxide (`cd` override), eza      | Do I actually reach for them?                          |
| tpm, vim-tmux-navigator          | Core tmux config is back (no plugins). Miss seamless nvim pane nav? |
| tmuxinator                       | Probably not                                           |
| rest of wezterm config           | Theme is back (Catppuccin Mocha, built into wezterm, nvim; hex colors in tmux). Needed for Shift+Enter in Claude Code? Font? |
| nvim: telescope, lsp/mason, cmp, treesitter, etc. | Add one at a time via `vim.pack` (no lazy.nvim). Update with `:lua vim.pack.update()`, commit the lockfile |
| node, go (Brewfile)              | Manage with `mise` instead of brew?                    |

Also fold in unmanaged startup files: `~/.zprofile` (brew shellenv), `~/.zshenv`
(flutter, cargo), `~/.config/mise/config.toml`.

## Phase 2: AI tooling

**Is dotfiles the right home for AI skills?** Partly:

- **Put in dotfiles:** things *I* author and want on every machine:
  - `~/.claude/CLAUDE.md`: global preferences for how agents should work with me
  - `~/.claude/skills/<name>/SKILL.md`: my own skills
  - `~/.claude/settings.json`: permissions, hooks, enabled plugins (see caveat below)
- **Don't vendor:** third-party skill collections like `mattpocock/skills`. Install them as
  Claude Code plugins so they keep getting updates, and record in dotfiles *which* plugins
  to install, not copies of the files. Fork or copy a single skill into `claude/` only once
  it's been customized.
- **Per-repo** conventions (issue tracker, test commands) belong in each project's own
  `CLAUDE.md` / `.claude/`, not in dotfiles.

Claude Code rewrites `~/.claude/settings.json` (e.g. `/model`, plugin installs).
It is stowed as a symlink, and writes go through the link (tested 2026-09-30 by toggling
a plugin), so changes show up as a git diff.

### Installing plugins on a new machine

Tested 2026-09-29 against a throwaway `CLAUDE_CONFIG_DIR`:

- Putting `enabledPlugins` / `extraKnownMarketplaces` in `settings.json` by hand does
  **not** install anything (`claude plugin list` shows nothing).
- These two commands work, and re-running them is safe (the second run reports "already
  installed" and still exits 0):
  ```sh
  claude plugin marketplace add mattpocock/skills
  claude plugin install mattpocock-skills@mattpocock
  ```
- After installing, Claude Code writes both keys into `settings.json` itself.

So, the Brewfile pattern:

1. `claude/plugins`: a list, one `<marketplace-repo> <plugin>@<marketplace>` per line:
   ```
   mattpocock/skills  mattpocock-skills@mattpocock
   ```
2. `bootstrap.sh`: `brew bundle`, then `stow` the packages, then marketplace add + install
   for each line in `claude/plugins`. A new machine is clone + `./bootstrap.sh`.
3. Optional: track `settings.json` so a plugin installed or removed by hand shows up as a
   git diff against the list.

Limitation: removing a line doesn't uninstall the plugin (same as a Brewfile without
`brew bundle cleanup`). A cleanup step could be added later. The list moves easily to
Nix/home-manager if I switch.

Later ideas: shared instructions for other agents (`AGENTS.md`) if more than one gets used.
