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
        themePackage = pkgs.libsForQt5.breeze-gtk;
        themeName = "breeze";
        iconThemePackage = pkgs.libsForQt5.breeze-icons;
        iconThemeName = "breeze";
        cursorThemePackage = pkgs.libsForQt5.breeze-icons;
        cursorThemeName = "breeze";
        cursorSize = 40;
        fontPackage = pkgs.noto-fonts;
        fontName = "Noto Sans";
        fontSize = 10;
        monoFontPackage = pkgs.hack-font;
        monoFontName = "Hack";
        monoFontSize = 10;
        qtPlatformTheme = "kde";
        qtStyleName = "breeze";
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
