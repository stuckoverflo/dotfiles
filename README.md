# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/) and [Homebrew](https://brew.sh/).

## Quick start

```bash
git clone https://github.com/fbarot/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make install      # brew bundle + stow symlinks
```

On a brand new machine (no Homebrew yet):

```bash
make bootstrap    # installs Homebrew, then runs make install
```

## Make targets

| Target | Description |
|--------|-------------|
| `make bootstrap` | Install Homebrew if missing, then full setup |
| `make install` | Install apps + symlink configs |
| `make apps` | Install/update Homebrew packages only |
| `make config` | Symlink configs only (safe to re-run) |
| `make update` | Update all Homebrew packages |
| `make clean` | Remove all stow symlinks |
| `make dump` | Dump current brew state to Brewfile |

## Structure

Each directory is a stow package that mirrors `$HOME`:

```
~/.dotfiles/
├── aerospace/     .aerospace.toml
├── direnv/        .config/direnv/direnvrc
├── ghostty/       .config/ghostty/config
├── git/           .gitconfig + .config/git/ignore
├── karabiner/     .config/karabiner/assets/complex_modifications/
├── nvim/          .config/nvim/
├── readline/      .inputrc
├── shell/         .config/shell/aliases.sh, utils.sh
├── starship/      .config/starship.toml
├── tmux/          .config/tmux/tmux.conf
└── zsh/           .zshrc
```

## Stowing and unstowing individual packages

Symlink a single package:

```bash
stow -t ~ tmux          # create symlinks for tmux package
```

Remove symlinks for a single package:

```bash
stow -t ~ -D tmux       # remove symlinks for tmux package
```

Re-stow (remove then re-create, useful after moving files around):

```bash
stow -t ~ --restow tmux
```

Dry-run to preview what would happen:

```bash
stow -t ~ --simulate --verbose tmux
```

## Adding a new config

1. Create a package directory: `mkdir -p newpkg/.config/newpkg`
2. Place config files mirroring their `$HOME` location
3. Add the package name to the `PACKAGES` array in `install.sh`
4. Run `make config`

## Machine-local git config

User name/email live in `~/.config/git/config.local` (not tracked):

```ini
[user]
    name = Your Name
    email = you@example.com
```
