{ pkgs, ... }:

{
  home.packages = with pkgs; [

    # Icons
    # kora-icon-theme tela-icon-theme beauty-line-icon-theme
    # fluent-icon-theme qogir-icon-theme whitesur-icon-theme
    # zafiro-icons nordzy-icon-theme vimix-icon-theme

    # Shells
    bashInteractive

    # nixGL
    nixgl.auto.nixGLDefault
    # pkgs.nixgl.auto.nixGLNvidia
    # pkgs.auto.nixGLNvidiaBumblebee
    # pkgs.nixGLIntel

    # Command Line Tools
    pulseaudio alsa-utils
    wget
    yafetch starfetch lolcat figlet
    rar zip unzip p7zip
    jq socat # TODO: these are required for eww workspaces, make them a proper dependency

    # Daemon Tools
    # xboxdrv

    # TUI Tools
    vim ranger btop pulsemixer networkmanager
    vimPlugins.yuck-vim

    # GUI Tools
    grim slurp wl-clipboard cliphist xdg-utils hyprpicker
    inotify-tools libnotify
    pavucontrol networkmanagerapplet
    gtklock

    # 
    imv mpv
    cinnamon.nemo-with-extensions
    cinnamon.nemo-emblems
    cinnamon.nemo-fileroller
    transmission-qt
 
    # 
    gimp inkscape

    #
    discord 
    # steam

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
}
