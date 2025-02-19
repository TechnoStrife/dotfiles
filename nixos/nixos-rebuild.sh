#!/usr/bin/env bash

# A rebuild script that commits on a successful build
set -e

cleanup() {
    mv ~/dotfiles/git ~/dotfiles/.git
}
trap cleanup 0

# Shows your changes
git diff -U0 '*.nix'

if [ -d ~/dotfiles/.git ]; then
    mv ~/dotfiles/.git ~/dotfiles/git
fi

# cd to your config dir
pushd ~/dotfiles/nixos/ >/dev/null

# Edit your config
# $EDITOR flake.nix

# Early return if no changes were detected (thanks @singiamtel!)
# if git diff --quiet '*.nix'; then
#     echo "No changes detected, exiting."
#     popd
#     exit 0
# fi

# Autoformat your nix files
# alejandra . &>/dev/null || ( alejandra . ; echo "formatting failed!" && exit 1)

nh os switch

# Get current generation metadata
current=$(nixos-rebuild list-generations | grep current)

mv ~/dotfiles/git ~/dotfiles/.git
trap - 0

# Commit all changes witih the generation metadata
if [ "$(hostname)" = "desktop" ]; then
    git commit -am "$current"
fi

# Back to where you were
popd >/dev/null

# Notify all OK!
# notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
