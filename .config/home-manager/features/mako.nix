{ user, theme, ... }:
{
  services.mako = {
    enable = true;
    anchor = "top-right";
    backgroundColor = "#111111cc";
    borderColor = "#33ccffee";
    borderSize = 1;
    borderRadius = 5;
    defaultTimeout = 3000;
    font = "${theme.fontName} 11";
    iconPath = "${user.home}/.nix-profile/share/icons/${theme.iconThemeName}";
  };
}
