{ pkgs, user, theme, ... }:
let
  launcher = pkgs.writeShellScriptBin "terminal" ''
    if [ "$1" == "" ]; then
      kitty
    else
      kitty $(which $1) ''${@:2}
    fi
  '';
in
{
  home.packages = [ launcher ];
  programs.kitty = {
    enable = true;
    font = {
      name = theme.monoFontName;
      package = theme.monoFontPackage;
      size = builtins.floor theme.fontSizeUI / 16 * 12;
    };
    shellIntegration.enableFishIntegration = true;
    settings = {
      foreground = "#${theme.colorScheme.foreground1Hex}";
      background = "#${theme.colorScheme.background1Hex}";
      background_opacity = "${theme.colorScheme.transparencyBackgroundRGB}";
      color0 = "#${theme.colorScheme.background1Hex}";
      color1 = "#${theme.colorScheme.redHex}";
      color2 = "#${theme.colorScheme.greenHex}";
      color3 = "#${theme.colorScheme.yellowHex}";
      color4 = "#${theme.colorScheme.blueHex}";
      color5 = "#${theme.colorScheme.magentaHex}";
      color6 = "#${theme.colorScheme.cyanHex}";
      color7 = "#${theme.colorScheme.foreground4Hex}";
      color8 = "#${theme.colorScheme.background4Hex}";
      color9 = "#${theme.colorScheme.redHex}";
      color10 = "#${theme.colorScheme.greenHex}";
      color11 = "#${theme.colorScheme.yellowHex}";
      color12 = "#${theme.colorScheme.blueHex}";
      color13 = "#${theme.colorScheme.magentaHex}";
      color14 = "#${theme.colorScheme.cyanHex}";
      color15 = "#${theme.colorScheme.foreground1Hex}";
    };
  };
}
