{ user, theme, ... }:
{
  services.mako = {
    enable = true;
    anchor = "top-right";
    backgroundColor = "#${theme.colorScheme.background1Hex}${theme.colorScheme.transparencyBackgroundHex}";
    borderColor = "#${theme.colorScheme.accentHex}${theme.colorScheme.transparencyForegroundHex}";
    borderSize = 1;
    borderRadius = 5;
    defaultTimeout = 3000;
    font = "${theme.fontName} 11";
    iconPath = "${user.home}/.nix-profile/share/icons/${theme.iconThemeName}";
  };
}
