{ config, pkgs, user, userHome, iconTheme, gBar, ... }:
{
  home.username = user;
  home.homeDirectory = userHome;

  home.stateVersion = "22.11";

  imports = [
    ./packages.nix
    ./environment.nix
    ./shell.nix
    ./editor.nix
    ./terminal.nix
    ./btop.nix
    ./hyprland.nix
    ./gammastep.nix
    ./default_applications.nix
    ./theme.nix
    ./eww.nix
    ./rofi.nix
    ./mako.nix
    ./trayer.nix
    ./browser.nix
    ./git.nix
    ./hitbox.nix
    gBar.homeManagerModules.x86_64-linux.default 
  ];

  home.file = {
    ".wallpapers".source = files/wallpapers;
    ".hushlogin".text = "";
  };

  programs.home-manager.enable = true;
}
