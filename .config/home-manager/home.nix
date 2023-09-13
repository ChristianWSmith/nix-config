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

      # TODO: Someday, we should try this again
      # Firefox had a weird transparent bar.
      # ./gradience.nix

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
