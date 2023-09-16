{ config, pkgs, user, ... }:
{
  home.username = user.name;
  home.homeDirectory = user.home;

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
    ./default-applications.nix
    ./theme.nix
    ./eww.nix
    ./mako.nix
    ./trayer.nix
    ./browser.nix
    ./git.nix
    ./hitbox.nix
    ./fuzzel.nix
    ./wlogout.nix
  ];

  home.file = {
    ".assets".source = files/assets;
    ".hushlogin".text = "";
  };

  programs.home-manager.enable = true;
}
