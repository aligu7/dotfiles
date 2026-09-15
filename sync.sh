#!/usr/bin/env bash
# Regenerate manifests from the live system. Run before committing.
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/manifest"

pacman -Qqen > pkglist-repo.txt
pacman -Qqem > pkglist-aur.txt

for d in ~/.config/omarchy/themes/*/; do
  [[ -d "$d/.git" ]] && printf "%s %s\n" "$(basename "$d")" "$(git -C "$d" remote get-url origin)"
done > themes.txt

for d in ~/.config/omarchy/plugins/*/; do
  [[ -d "$d/.git" ]] && printf "%s %s\n" "$(basename "$d")" "$(git -C "$d" remote get-url origin)"
done > plugins.txt

systemctl --user list-unit-files --state=enabled --no-legend --no-pager | awk '{print $1}' > systemd-enabled.txt
find ~/.config/systemd/user -maxdepth 1 -type l -lname '/dev/null' -printf '%f\n' | sort > systemd-masked.txt

cd ..
echo "Manifests refreshed:"
git status --short manifest/
