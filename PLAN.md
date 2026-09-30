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
└── (later) claude/.claude/{CLAUDE.md,skills/,settings.json}
```

Why per-package rather than `stow .`: each tool can be added, removed or tested on its own
(`stow -D tmux`), and the repo tree shows what's managed.

Machine-specific or secret settings go in `~/.zshrc.local`, which is untracked.

## Phase 0: scaffold (done)

- Old repo moved to `~/dotfiles-legacy` (history, remote and uncommitted changes intact)
- New `~/dotfiles` with `zsh` and `git` only
- Minimal `.zshrc`: PATH, editor, history, completion, vi keys, plain prompt
- `openjdk@21` PATH moved to `~/.zshrc.local`

## Phase 1: live with it for a week, re-add only what hurts

Candidates from legacy, **not** carried over. Add each back only if missed:

| Legacy                           | Question to ask                                        |
|----------------------------------|--------------------------------------------------------|
| zinit + p10k + 3 zsh plugins     | Is a plain prompt fine? If not, try `starship` (one binary, no plugin manager) |
| zoxide (`cd` override), eza      | Do I actually reach for them?                          |
| tmux + tpm + catppuccin          | Still using tmux, or do terminal splits / agent sessions cover it? |
| tmuxinator                       | Probably not                                           |
| wezterm config                   | Needed for Shift+Enter in Claude Code? Font?           |
| nvim (lazy, mason, lsp, tree)    | Rebuild from zero: how much editing happens in nvim vs. agent now? |
| node, go (Brewfile)              | Manage with `mise` instead of brew?                    |

Also fold in unmanaged startup files: `~/.zprofile` (brew shellenv), `~/.zshenv`
(flutter, cargo), `~/.config/mise/config.toml`.

## Phase 2: AI tooling

**Is dotfiles the right home for AI skills?** Partly:

- **Put in dotfiles:** things *I* author and want on every machine:
  - `~/.claude/CLAUDE.md`: global preferences for how agents should work with me
  - `~/.claude/skills/<name>/SKILL.md`: my own skills
  - `~/.claude/settings.json`: permissions, hooks, enabled plugins (see caveat below)
- **Don't vendor:** third-party skill collections like `mattpocock/skills`. Install them as a
  Claude Code plugin (`claude plugins install mattpocock-skills`) so they get updates, and
  let dotfiles record *that* they're enabled (the `enabledPlugins` entry in settings.json),
  not copies of the files. Fork or copy a single skill into `claude/` only once it's been
  customized.
- **Per-repo** conventions (issue tracker, test commands) belong in each project's own
  `CLAUDE.md` / `.claude/`, not in dotfiles.

Caveat: Claude Code rewrites `~/.claude/settings.json` (e.g. `/model`). Symlink it and
check that writes go through the link, or keep a tracked base file and treat local
drift as expected. Decide when adding the `claude` package.

Later ideas: a `bootstrap.sh` (brew bundle + stow + plugin installs) once there's enough
to justify it; shared instructions for other agents (`AGENTS.md`) if more than one gets used.
