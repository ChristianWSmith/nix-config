{ user, ... }:
{
  home.username = user.name;
  home.homeDirectory = user.home;

  home.stateVersion = "22.11";

  imports = [
    ./packages.nix
    ./environment.nix
    ./shell.nix
    ./theme.nix
    ./gradience.nix
    ./gnome-base.nix
    ./gnome-extensions.nix
    ./hitbox.nix
  ];

  home.file = {
    ".assets".source = ./files/assets;
    ".hushlogin".text = "";
  };

  programs.home-manager.enable = true;
}
