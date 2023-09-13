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

      user = {
        name = "christian";
        home = "/home/christian";
        fullName = "Christian Smith";
        email = "smith.christian.william@gmail.com";
      };

      theme = {
        themePackage = pkgs.adw-gtk3;
        themeName = "adw-gtk3-dark";
        iconThemePackage = pkgs.gnome.adwaita-icon-theme;
        iconThemeName = "Adwaita";
        cursorThemePackage = pkgs.gnome.adwaita-icon-theme;
        cursorThemeName = "Adwaita";
        cursorSize = 40;
        fontPackage = pkgs.cantarell-fonts;
        fontName = "Cantarell";
        fontSize = 11;
        monoFontPackage = pkgs.source-code-pro;
        monoFontName = "Source Code Pro";
        monoFontSize = 10;
      };

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      homeConfigurations."${user.name}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs user theme pkgs; };
        modules = [ ./home.nix ];
      };
    };
}
