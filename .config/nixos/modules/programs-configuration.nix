{ pkgs, ... }:
{
  programs = {
    gnome-disks.enable = true;
    dconf.enable = true;
    hyprland.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
  xdg.portal = {
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
  hardware = {
    opengl.enable = true;
    bluetooth.enable = true;
  };
}
