#!/usr/bin/env bash
# Bootstrap this dotfiles repo onto an Omarchy machine.
#
#   git clone <repo> ~/dotfiles && ~/dotfiles/install.sh
#
# Idempotent: safe to re-run after an `omarchy update` to re-link anything
# that drifted.

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES"

PACKAGES=(hypr omarchy terminals shell bin systemd apps)

say() { printf '\n\033[1;34m==>\033[0m %s\n' "$*"; }

# --- 1. Stow the symlink farm ------------------------------------------------
say "Stowing packages: ${PACKAGES[*]}"
command -v stow >/dev/null || { echo "stow is not installed: sudo pacman -S stow"; exit 1; }
for pkg in "${PACKAGES[@]}"; do
  echo "  - $pkg"
  stow --restow "$pkg"
done

# --- 2. Re-clone Omarchy themes ----------------------------------------------
# Themes are upstream git repos (~740M), tracked by URL rather than vendored.
say "Cloning Omarchy themes"
mkdir -p ~/.config/omarchy/themes
while read -r name url; do
  [[ -z "${name:-}" ]] && continue
  dest=~/.config/omarchy/themes/"$name"
  if [[ -d "$dest/.git" ]]; then
    echo "  - $name (present, pulling)"
    git -C "$dest" pull --quiet --ff-only || echo "    ! pull failed, leaving as-is"
  else
    echo "  - $name (cloning)"
    git clone --quiet --depth 1 "$url" "$dest"
  fi
done < manifest/themes.txt

# --- 3. Re-clone Omarchy shell plugins ---------------------------------------
say "Cloning Omarchy shell plugins"
mkdir -p ~/.config/omarchy/plugins
while read -r name url; do
  [[ -z "${name:-}" ]] && continue
  dest=~/.config/omarchy/plugins/"$name"
  if [[ -d "$dest/.git" ]]; then
    echo "  - $name (present, pulling)"
    git -C "$dest" pull --quiet --ff-only || echo "    ! pull failed, leaving as-is"
  else
    echo "  - $name (cloning)"
    git clone --quiet --depth 1 "$url" "$dest"
  fi
done < manifest/plugins.txt

# --- 4. Theme overlay fixes --------------------------------------------------
# Deployed as real file copies, NOT symlinks: `omarchy theme set` builds its
# staged theme with `cp -r`, which preserves symlinks as symlinks rather than
# following them. A symlinked overlay file ends up copied-as-a-symlink into a
# different directory depth and dangles there, breaking theme-set entirely.
if [[ -d manifest/theme-overlays ]]; then
  say "Deploying theme overlay fixes"
  for theme_dir in manifest/theme-overlays/*/; do
    theme="$(basename "$theme_dir")"
    dest=~/.config/omarchy/themes/"$theme"
    mkdir -p "$dest"
    cp -r "$theme_dir"* "$dest"/
    echo "  - $theme"
  done
fi

# --- 5. systemd user units ---------------------------------------------------
# Unit *files* are stowed above; the enable/mask state is symlinks systemd
# generates, so recreate it here.
say "Enabling systemd user units"
systemctl --user daemon-reload
for unit in systemd/.config/systemd/user/*.{service,timer}; do
  [[ -e "$unit" ]] || continue
  name="$(basename "$unit")"
  # Only units that declare an [Install] section can be enabled.
  grep -q '^\[Install\]' "$unit" || continue
  echo "  - enable $name"
  systemctl --user enable --now "$name" 2>/dev/null || echo "    ! could not enable $name"
done

say "Masking units"
while read -r unit; do
  [[ -z "${unit:-}" ]] && continue
  echo "  - mask $unit"
  systemctl --user mask "$unit" 2>/dev/null || true
done < manifest/systemd-masked.txt

# --- 6. Packages (opt-in) ----------------------------------------------------
if [[ "${1:-}" == "--packages" ]]; then
  say "Installing repo packages"
  sudo pacman -S --needed --noconfirm - < manifest/pkglist-repo.txt
  say "Installing AUR packages"
  command -v yay >/dev/null \
    && yay -S --needed --noconfirm - < manifest/pkglist-aur.txt \
    || echo "  ! yay not found, skipping AUR packages"
else
  say "Skipping packages (re-run with --packages to install them)"
fi

say "Done. Reload your session: omarchy restart shell && hyprctl reload"
