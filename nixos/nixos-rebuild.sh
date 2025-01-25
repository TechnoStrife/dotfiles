#!/usr/bin/env bash

# A rebuild script that commits on a successful build
set -e

# cd to your config dir
pushd ~/dotfiles/nixos/ >/dev/null

# Edit your config
$EDITOR flake.nix

# Early return if no changes were detected (thanks @singiamtel!)
# if git diff --quiet '*.nix'; then
#     echo "No changes detected, exiting."
#     popd
#     exit 0
# fi

# Autoformat your nix files
# alejandra . &>/dev/null || ( alejandra . ; echo "formatting failed!" && exit 1)

# Shows your changes
git diff -U0 '*.nix'

echo "NixOS Rebuilding..."

# Rebuild, output simplified errors, log trackebacks
echo "Full log at /tmp/nixos-switch.log"
sudo nixos-rebuild switch --show-trace --flake .#desktop &> /tmp/nixos-switch.log || (grep error /tmp/nixos-switch.log --color && exit 1)

# Get current generation metadata
current=$(nixos-rebuild list-generations | grep current)

# Commit all changes witih the generation metadata
git commit -am "$current"

# Back to where you were
popd >/dev/null

# Notify all OK!
# notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
