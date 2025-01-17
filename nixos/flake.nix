{
  description = "Home Manager configuration of tech";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    ayugram-desktop.url = "github:/ayugram-port/ayugram-desktop/release?submodules=1";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
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
      };

      # homeConfigurations."tech" = home-manager.lib.homeManagerConfiguration {
      #   inherit pkgs;
      # 
      #   modules = [  ];
      #   extraSpecialArgs = { inherit inputs; };
      # };
    };
}
