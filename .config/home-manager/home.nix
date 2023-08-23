{ config, pkgs, hostname, ... }:
let
  homeDirectory = "/home/${hostname}";
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = hostname;
  home.homeDirectory = homeDirectory;

  home.stateVersion = "22.11";

  imports = [
    ./packages.nix
    ./environment.nix
    ./shell.nix
    ./hyprland.nix
    ./eww.nix
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".wallpapers".source = files/wallpapers;


    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.foot.enable = true;
  programs.foot.server.enable = true;

  programs.git.enable = true;
  programs.git.userEmail = "smith.christian.william@gmail.com";
  programs.git.userName = "Christian Smith";

  gtk.enable = true;
  gtk.cursorTheme.package = pkgs.gnome.adwaita-icon-theme;
  gtk.cursorTheme.name = "Adwaita";
  gtk.cursorTheme.size = 40;
  gtk.theme.package = pkgs.adw-gtk3;
  gtk.theme.name = "adw-gtk3-dark";
  gtk.iconTheme.package = pkgs.papirus-icon-theme;
  gtk.iconTheme.name = "Papirus";
  qt.enable = true;
  qt.platformTheme = "gtk";
  qt.style.name = "adwaita-dark";
}
