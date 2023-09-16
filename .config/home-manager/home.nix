{ user, ... }:
{
  home.username = user.name;
  home.homeDirectory = user.home;

  home.stateVersion = "22.11";

  imports = [
    ./features/packages.nix
    ./features/environment.nix
    ./features/shell.nix
    ./features/theme.nix
    ./features/gnome-base.nix
    ./features/gnome-extensions.nix
    ./features/hitbox.nix
    ./features/default-applications.nix

    ./experimental/firefox-gnome-theme.nix
  ];

  home.file = {
    ".assets".source = ./files/assets;
    ".hushlogin".text = "";
  };

  programs.home-manager.enable = true;
}
