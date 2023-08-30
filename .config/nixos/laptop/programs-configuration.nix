{ pkgs, ... }:
{
  programs.dconf.enable = true;
  programs.hyprland.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  xdg.portal = {
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
  hardware.opengl.enable = true;
}
