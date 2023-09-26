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
    vdal.url = "github:ChristianWSmith/vdal";
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

      palette = inputs.nix-colors.colorSchemes.material-darker.colors;

      theme = {
        colorScheme = {
          transparencyBackgroundHex = "CC";
          transparencyForegroundHex = "EE";
          transparencyHeavyShadeHex = "5C";
          transparencyLightShadeHex = "14";

          transparencyBackgroundRGB = "0.8";
          transparencyForegroundRGB = "0.93";
          transparencyHeavyShadeRGB = "0.36";
          transparencyLightShadeRGB = "0.08";

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
          secondaryAccentHex = theme.colorScheme.greenHex;
          dangerHex = theme.colorScheme.redHex;
          warningHex = theme.colorScheme.yellowHex;
          infoHex = theme.colorScheme.blueHex;
          successHex = theme.colorScheme.greenHex;
          specialHex = theme.colorScheme.magentaHex;
          
          accentRGB = theme.colorScheme.cyanRGB;
          secondaryAccentRGB = theme.colorScheme.greenRGB;
          dangerRGB = theme.colorScheme.redRGB;
          warningRGB = theme.colorScheme.yellowRGB;
          infoRGB = theme.colorScheme.blueRGB;
          successRGB = theme.colorScheme.greenRGB;
          specialRGB = theme.colorScheme.magentaRGB;

          newtForeground = "white";
          newtBackground = "black";
          newtAccent = "cyan";
        };
        borderWidth = 1;
        borderRadius = 5;
        gapsIn = 3;
        gapsOut = 5;

        fontPackage = pkgs.noto-fonts;
        fontName = "Noto Sans";
        fontSize = 11;
        fontSizeUI = 16;
        monoFontPackage = pkgs.noto-fonts;
        monoFontName = "Noto Sans Mono";
        monoFontSize = 10;

        cursorThemePackage = pkgs.gnome.adwaita-icon-theme;
        cursorThemeName = "Adwaita";
        cursorSize = 40;
        
        iconThemePackage = pkgs.flat-remix-icon-theme;
        iconThemeName = "Flat-Remix-Cyan-Dark";

        themePackage = pkgs.adw-gtk3;
        themeName = "adw-gtk3-dark";
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
