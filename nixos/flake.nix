{
  description = "Home Manager configuration of tech";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # nixos anywhere
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    # nixos-facter-modules.url = "github:numtide/nixos-facter-modules";

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
      # nixos-facter-modules,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
	  modules = [
            ./hosts/desktop/configuration.nix

	    home-manager.nixosModules.home-manager
	    {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.tech = import ./home.nix;
            }
	  ];
	};

        # nixos anywhere
        # nix run github:nix-community/nixos-anywhere -- --flake .#homeserver --generate-hardware-config nixos-generate-config ./hosts/homelab/hardware-configuration.nix <hostname>
        # nix run github:nix-community/nixos-anywhere -- --flake .#homeserver --vm-test
        # nix run github:nix-community/nixos-anywhere -- --flake .#homeserver --target-host <hostname>
        # ssh-keygen -R <ip address>
        homeserver = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./hosts/homeserver/configuration.nix
            ./hosts/homeserver/hardware-configuration.nix
          ];
        };

        # Slightly experimental: Like generic, but with nixos-facter (https://github.com/numtide/nixos-facter)
        # nixos-anywhere --flake .#generic-nixos-facter --generate-hardware-config nixos-facter facter.json <hostname>
        # generic-nixos-facter = nixpkgs.lib.nixosSystem {
        #   system = "x86_64-linux";
        #   modules = [
        #     disko.nixosModules.disko
        #     ./configuration.nix
        #     nixos-facter-modules.nixosModules.facter
        #     {
        #       config.facter.reportPath =
        #         if builtins.pathExists ./facter.json then
        #           ./facter.json
        #         else
        #           throw "Have you forgotten to run nixos-anywhere with `--generate-hardware-config nixos-facter ./facter.json`?";
        #     }
        #   ];
        # };
      };

      # homeConfigurations."tech" = home-manager.lib.homeManagerConfiguration {
      #   inherit pkgs;
      # 
      #   modules = [  ];
      #   extraSpecialArgs = { inherit inputs; };
      # };
    };
}

