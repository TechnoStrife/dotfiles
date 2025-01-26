{
  description = "Home Manager configuration of tech";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # nixos anywhere
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ayugram-desktop.url = "github:/ayugram-port/ayugram-desktop/release?submodules=1";
  };

  outputs =
    {
      nixpkgs, 
      home-manager, 
      disko,
      ...
    }@inputs:
    let
        stateVersion = "24.11";
        username = "tech";
        specialArgs = {inherit inputs username stateVersion;};
    in {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
	  modules = [
            ./hosts/desktop/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = inputs // specialArgs;
              home-manager.users.${username} = import ./home/desktop.nix;
            }
	  ];
	};

        # nixos anywhere
        # nix run github:nix-community/nixos-anywhere -- --flake .#homeserver --generate-hardware-config nixos-generate-config ./hosts/homelab/hardware-configuration.nix <hostname>
        # nix run github:nix-community/nixos-anywhere -- --flake .#homeserver --vm-test
        # nix run github:nix-community/nixos-anywhere -- --flake .#homeserver --target-host <hostname>
        # ssh-keygen -R <ip address>
        homeserver = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./hosts/homeserver/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = inputs // specialArgs;
              home-manager.users.${username} = import ./home/server.nix;
            }
          ];
        };

      };

      # homeConfigurations."tech" = home-manager.lib.homeManagerConfiguration {
      #   inherit pkgs;
      # 
      #   modules = [  ];
      #   extraSpecialArgs = { inherit inputs; };
      # };
    };
}

