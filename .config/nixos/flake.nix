{
  description = "NixOS Flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in
  {
    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };
	modules = [
          ./default-configuration.nix
	];
      }; 
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };
	modules = [
          ./desktop-configuration.nix
	];
      };
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };
	modules = [
          ./laptop-configuration.nix
	];
      };
    };
  };
}
