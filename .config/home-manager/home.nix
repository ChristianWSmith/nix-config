{ inputs, user, ... }:
{
  home.username = user.name;
  home.homeDirectory = user.home;

  home.stateVersion = "22.11";

  imports = [
    ./features/packages.nix
    ./features/environment.nix
    ./features/shell.nix
    ./features/hitbox.nix

  ];

  home.file = {
    ".assets".source = ./files/assets;
    ".hushlogin".text = "";
  };

  programs.home-manager.enable = true;
}
