{ config, pkgs, user, userHome, iconTheme, ... }:
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
  ];

  home.file = {
    ".wallpapers".source = files/wallpapers;
    ".hushlogin".text = "";
    ".local/share/applications/scanner.desktop".text = ''
      [Desktop Entry]
      Name=Scanner
      Comment=Scan documents.
      Exec=utsushi
      Icon=scanner
      Terminal=false
      Type=Application
      Categories=Office; 
    '';
  };

  programs.home-manager.enable = true;
}
