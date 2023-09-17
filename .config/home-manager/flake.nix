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
    nix-colors.url = "github:misterio77/nix-colors";
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

      palette = inputs.nix-colors.colorSchemes.nord.colors;

      theme = {
        colorScheme = {
          transparencyBackgroundHex = "CC";
          transparencyForegroundHex = "EE";
          transparencyBackgroundRGB = "0.8";
          transparencyForegroundRGB = "0.93";
          background1Hex = palette.base00;
          background2Hex = palette.base01;
          background3Hex = palette.base02;
          background4Hex = palette.base03;
          foreground4Hex = palette.base04;
          foreground3Hex = palette.base05;
          foreground2Hex = palette.base06;
          foreground1Hex = palette.base07;
          background1RGB = inputs.nix-colors.lib.conversions.hexToRGBString "," palette.base00;
          background2RGB = inputs.nix-colors.lib.conversions.hexToRGBString "," palette.base01;
          background3RGB = inputs.nix-colors.lib.conversions.hexToRGBString "," palette.base02;
          background4RGB = inputs.nix-colors.lib.conversions.hexToRGBString "," palette.base03;
          foreground4RGB = inputs.nix-colors.lib.conversions.hexToRGBString "," palette.base04;
          foreground3RGB = inputs.nix-colors.lib.conversions.hexToRGBString "," palette.base05;
          foreground2RGB = inputs.nix-colors.lib.conversions.hexToRGBString "," palette.base06;
          foreground1RGB = inputs.nix-colors.lib.conversions.hexToRGBString "," palette.base07;
          redHex = palette.base08;
          orangeHex = palette.base09;
          yellowHex = palette.base0A;
          greenHex = palette.base0B;
          cyanHex = palette.base0C;
          blueHex = palette.base0D;
          magentaHex = palette.base0E;
          brownHex = palette.base0F;
          redRGB = inputs.nix-colors.lib.conversions.hexToRGBString "," palette.base08;
          orangeRGB = inputs.nix-colors.lib.conversions.hexToRGBString "," palette.base09;
          yellowRGB = inputs.nix-colors.lib.conversions.hexToRGBString "," palette.base0A;
          greenRGB = inputs.nix-colors.lib.conversions.hexToRGBString "," palette.base0B;
          cyanRGB = inputs.nix-colors.lib.conversions.hexToRGBString "," palette.base0C;
          blueRGB = inputs.nix-colors.lib.conversions.hexToRGBString "," palette.base0D;
          magentaRGB = inputs.nix-colors.lib.conversions.hexToRGBString "," palette.base0E;
          brownRGB = inputs.nix-colors.lib.conversions.hexToRGBString "," palette.base0F;

          accentHex = theme.colorScheme.cyanHex;
          accentRGB = theme.colorScheme.cyanRGB;
        };
        borderWidth = 1;
        borderRadius = 5;

        # themePackage = pkgs.nordic;
        # themeName = "Nordic-darker";
        # iconThemePackage = pkgs.nordzy-icon-theme;
        # iconThemeName = "Nordzy-dark";
        # cursorThemePackage = pkgs.capitaine-cursors-themed;
        # cursorThemeName = "Capitaine Cursors (Palenight)";
        # cursorSize = 40;
        # fontPackage = pkgs.noto-fonts;
        # fontName = "Noto Sans";
        # fontSize = 11;

	      themePackage = pkgs.adw-gtk3;
        themeName = "adw-gtk3-dark";
        iconThemePackage = pkgs.papirus-icon-theme;
        iconThemeName = "Papirus-Dark";
        cursorThemePackage = pkgs.gnome.adwaita-icon-theme;
        cursorThemeName = "Adwaita";
        cursorSize = 40;
        fontPackage = pkgs.noto-fonts;
        fontName = "Noto Sans";
        fontSize = 11;
        monoFontPackage = pkgs.noto-sans;
        monoFontName = "Noto Sans Mono";
        monoFontSize = 10;
        qtPlatformTheme = "gtk";
        qtStyleName = "adwaita-dark";
      };

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      homeConfigurations."${user.name}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs user theme pkgs; };
        modules = [ 
          inputs.nix-colors.homeManagerModules.default
          ./home.nix 
          ];
      };
    };
}
