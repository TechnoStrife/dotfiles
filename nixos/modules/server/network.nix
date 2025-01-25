{ config, pkgs, inputs, ... }:

let
  secrets = import ../../secrets.nix;
in
{
  networking.wireless = {
    enable = true;  # Enables wireless support via wpa_supplicant.

    # wpa_passphrase SSID PSK
    networks = {
      ${secrets.wifissid} = {
        pskRaw = secrets.wifipsk;
      };
    };
  };
}
