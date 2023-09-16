{
  description = "Home Manager configuration of christian";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";

      user = "christian";
      userHome = "/home/${user}";
      userFullName = "Christian Smith";
      userEmail = "smith.christian.william@gmail.com";

      iconTheme = "WhiteSur-dark";
      font = "Noto Sans";
      fontMono = "Noto Sans Mono";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      homeConfigurations."${user}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs user userHome userEmail userFullName iconTheme font fontMono pkgs; };
        modules = [ ./home.nix ];
      };
    };
}
