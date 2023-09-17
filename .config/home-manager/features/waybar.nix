{ pkgs, ... }:
let
  zenToggle = pkgs.writeShellScriptBin "zen-toggle" ''
    if pgrep waybar; then
      pkill waybar
    else
      waybar & disown
    fi
  '';
in
{
  programs.waybar.enable = true;
  home.packages = with pkgs; [
    nerdfonts
    zenToggle
  ];
}
