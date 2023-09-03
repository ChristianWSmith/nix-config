{ userHome, iconTheme, font, ... }:
{
  services.mako = {
    enable = true;
    anchor = "top-right";
    backgroundColor = "#111111cc";
    borderColor = "#33ccffee";
    borderSize = 1;
    borderRadius = 5;
    defaultTimeout = 5000;
    font = "${font} 11";
    iconPath = "${userHome}/.nix-profile/share/icons/${iconTheme}";
  };
}
