{ config, pkgs, inputs, hostname, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${hostname}";
  home.homeDirectory = "/home/${hostname}";

  home.stateVersion = "22.11";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.vim
    pkgs.nixgl.auto.nixGLDefault
    # pkgs.nixgl.auto.nixGLNvidia
    # pkgs.auto.nixGLNvidiaBumblebee
    # pkgs.nixGLIntel

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/christian/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.extraConfig = ''
    source=~/.config/hypr/binds.conf
    source=~/.config/hypr/autoexec.conf
    source=~/.config/hypr/windowrules.conf
    source=~/.config/hypr/input.conf
    source=~/.config/hypr/appearance.conf
    source=~/.config/hypr/environment.conf
  '';

  programs.eww.package = pkgs.eww-wayland;
  programs.eww.enable = true;
  programs.eww.configDir = ./eww;

  programs.foot.enable = true;
  programs.foot.server.enable = true;

  programs.git.enable = true;
  programs.git.userEmail = "smith.christian.william@gmail.com";
  programs.git.userName = "Christian Smith";
}
