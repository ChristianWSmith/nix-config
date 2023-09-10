{ config, pkgs, user, userHome, lib, ... }:
{
  home.username = user;
  home.homeDirectory = userHome;

  home.stateVersion = "22.11";

  imports = [
    ./packages.nix
    ./environment.nix
    ./shell.nix
    ./theme.nix
    ./hitbox.nix
  ];

  home.file = {
    ".hushlogin".text = "";
  };

  programs.home-manager.enable = true;
}
