# dotfiles

My Omarchy (Arch + Hyprland) config, managed with GNU Stow.

## New machine setup

    git clone <this-repo> ~/dotfiles
    ~/dotfiles/install.sh --packages

## Stow cheat sheet

Everything in `~/.config` etc. is a symlink pointing back into this repo.
One real file, two doors into it.

**Editing something that already exists?** Just edit it, don't touch stow.

**Added or deleted a file?** Do it inside `~/dotfiles`, then run:

    cd ~/dotfiles && stow --restow <package>

Packages: `hypr` `omarchy` `terminals` `shell` `bin` `systemd` `apps`

Then always:

    git add -A && git commit -m "msg" && git push

## What's in each package

- `hypr` — hyprland config
- `omarchy` — bar, hooks, backgrounds, theme overlays, shell.json
- `terminals` — alacritty / foot / kitty / ghostty
- `shell` — zshrc, gitconfig, bashrc, p10k
- `bin` — my scripts in `~/.local/bin`
- `systemd` — user units I wrote myself
- `apps` — nvim, btop, git, tmux, starship, lazygit, fastfetch
- `manifest` — package lists + stuff that can't be a symlink (see below)

## Gotchas

- `.stowrc` has `--no-folding` set, don't remove it. Without it, stow
  collapses a whole folder into one symlink, and Omarchy's update backups
  end up inside the repo.
- Omarchy themes/plugins under `~/.config/omarchy/{themes,plugins}` aren't
  tracked as files — they're git clones. Only their URLs live in `manifest/`,
  and `install.sh` re-clones them.
- Packaged systemd units (`syncthing`, `bt-agent`, `wireplumber`...) have no
  local file to stow, just an on/off state. They're names in
  `manifest/systemd-enabled.txt`, and `install.sh` enables them from that list.
- Theme overlay fixes in `manifest/theme-overlays/` must stay real files,
  never symlinks — `omarchy theme set` copies them with `cp -r`, which breaks
  on a symlink. Edit there, then copy manually into
  `~/.config/omarchy/themes/<name>/` and re-run `omarchy theme set <name>`.
- `hypr/shaders/`, btop's `current.theme`, nvim's `theme.lua` — Omarchy
  rewrites these live when you switch themes. Never touch them, never stow them.

## Refresh manifests (packages, themes, systemd state)

    ~/dotfiles/sync.sh
