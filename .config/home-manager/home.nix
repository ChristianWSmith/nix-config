{ inputs, config, pkgs, user, ... }:
{
  home.username = user.name;
  home.homeDirectory = user.home;

  home.stateVersion = "22.11";

  imports = [
    ./features/packages.nix
    ./features/environment.nix
    ./features/shell.nix
    ./features/editor.nix
    ./features/terminal.nix
    ./features/hyprland.nix
    ./features/default-applications.nix
    ./features/theme.nix
    ./features/mako.nix
    ./features/gammastep.nix
    ./features/browser.nix
    ./features/hitbox.nix
    ./features/fuzzel.nix
    ./features/wlogout.nix
    ./features/waybar.nix
    ./features/gtklock.nix
  ];

  home.file = {
    ".assets".source = files/assets;
    ".hushlogin".text = "";
  };

  programs.home-manager.enable = true;
}
