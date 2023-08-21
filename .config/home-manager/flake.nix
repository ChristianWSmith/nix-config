{
  description = "Home Manager configuration of christian";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl.url = "github:guibou/nixGL";
  };

  outputs = { nixpkgs, home-manager, nixgl, ... }@inputs:
    let
      system = "x86_64-linux";
      hostname = "christian";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nixgl.overlay ];
        config.allowUnfree = true;
      };
    in {
      homeConfigurations."${hostname}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs hostname pkgs; };
        modules = [ ./home.nix ];
      };
    };
}
