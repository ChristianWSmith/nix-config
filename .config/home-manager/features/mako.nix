{ pkgs, user, theme, lib, ... }:
let
  notifyClipboard = pkgs.writeShellScriptBin "notify-clipboard" ''
    paste=$(wl-paste)

    if [ "$paste" ]
    then
      notify-send "Clipboard: $paste"
    fi
  '';
in
{
  home.packages = [ notifyClipboard ];
  services.mako = {
    enable = true;
    anchor = "top-center";
    backgroundColor = "#${theme.colorScheme.background1Hex}${theme.colorScheme.transparencyBackgroundHex}";
    borderColor = "#${theme.colorScheme.accentHex}${theme.colorScheme.transparencyForegroundHex}";
    textColor = "#${theme.colorScheme.foreground1Hex}";
    progressColor = "#${theme.colorScheme.accentHex}";
    borderSize = theme.borderWidth;
    borderRadius = theme.borderRadius;
    defaultTimeout = 3000;
    font = "${theme.fontName} ${builtins.toString theme.fontSize}";
    iconPath = "${user.home}/.nix-profile/share/icons/${theme.iconThemeName}";
  };
}
