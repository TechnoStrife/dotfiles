
# Install

When rebuilding on an already installed system:
1. Enable flakes in configuration.nix
    ```nix
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    ```
2. `sudo nixos-rebuild switch --flake .#desktop`
3. Reset keyboard settings (for some reason):
    ```bash
    gsettings reset org.gnome.desktop.input-sources xkb-options
    gsettings reset org.gnome.desktop.input-sources sources
    ```
