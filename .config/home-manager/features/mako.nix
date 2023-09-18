{ user, theme, lib, ... }:
{
  services.mako = {
    enable = true;
    anchor = "top-center";
    backgroundColor = "#${theme.colorScheme.background1Hex}${theme.colorScheme.transparencyBackgroundHex}";
    borderColor = "#${theme.colorScheme.accentHex}${theme.colorScheme.transparencyForegroundHex}";
    borderSize = theme.borderWidth;
    borderRadius = theme.borderRadius;
    defaultTimeout = 3000;
    font = "${theme.fontName} ${builtins.toString theme.fontSize}";
    iconPath = "${user.home}/.nix-profile/share/icons/${theme.iconThemeName}";
  };
}
