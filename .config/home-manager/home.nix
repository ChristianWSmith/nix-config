{ config, pkgs, user, userHome, iconTheme, ... }:
{
  home.username = user;
  home.homeDirectory = userHome;

  home.stateVersion = "22.11";

  imports = [
    #./packages.nix
    #./environment.nix
    ./shell.nix
    ./editor.nix
    #./terminal.nix
    #./gammastep.nix
    #./default-applications.nix
    #./theme.nix
    #./browser.nix
    ./git.nix
    #./hitbox.nix
  ];

  home.file = {
    ".hushlogin".text = "";
  };

  programs.home-manager.enable = true;
}
