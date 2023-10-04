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
    ./features/firefox.nix
    ./features/chromium.nix
    ./features/hitbox.nix
    ./features/fuzzel.nix
    ./features/wlogout.nix
    ./features/waybar.nix
    ./features/gtklock.nix
    ./features/hyprpaper.nix
    ./features/vscode.nix
    ./features/ranger.nix
    ./features/mpd.nix
    ./features/screenshot.nix
    ./features/extra-desktop-files.nix
    ./features/google-drive.nix
    ./features/rofi.nix
  ];

  home.file = {
    ".assets".source = files/assets;
    ".hushlogin".text = "";
  };

  programs.home-manager.enable = true;
}
