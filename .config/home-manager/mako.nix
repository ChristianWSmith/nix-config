{ userHome, iconTheme, ... }:
{
  services.mako = {
    enable = true;
    anchor = "bottom-left";
    backgroundColor = "#111111cc";
    borderColor = "#33ccffee";
    borderSize = 1;
    borderRadius = 5;
    defaultTimeout = 5000;
    font = "Noto Sans 11";
    iconPath = "${userHome}/.nix-profile/share/icons/${iconTheme}";
  };
}
