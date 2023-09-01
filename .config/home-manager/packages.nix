{ pkgs, ... }:
let
  my-python-packages = ps: with ps; [
    psutil
    pygobject3
  ];
in
{
  programs.imv = {
    enable = true;
    settings = {
      options.overlay = true;
    };
  };

  home.packages = with pkgs; [

    (python3.withPackages my-python-packages)

    # Fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif

    # Shells
    bashInteractive

    # nixGL
    nixgl.auto.nixGLDefault
    # pkgs.nixgl.auto.nixGLNvidia
    # pkgs.auto.nixGLNvidiaBumblebee
    # pkgs.nixGLIntel

    # Command Line Tools
    pulseaudio 
    alsa-utils
    wget
    yafetch 
    starfetch 
    lolcat 
    figlet
    rar 
    zip 
    unzip 
    p7zip
    imagemagick # TODO: this is required by get-icon, make it a proper dependency
    jq socat # TODO: these are required for eww workspaces, make them a proper dependency

    # Daemon Tools
    xboxdrv

    # TUI Tools
    ranger 
    pulsemixer 
    networkmanager
    vimPlugins.yuck-vim

    # GUI Tools
    grim
    rofimoji
    slurp 
    wf-recorder
    wl-clipboard 
    cliphist 
    xdg-utils 
    hyprpicker
    inotify-tools
    libnotify
    pavucontrol 
    networkmanagerapplet
    gtklock
    gnome.gnome-font-viewer
    gamescope

    # Files
    mpv
    mpd
    zathura
    vlc
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    cinnamon.nemo-with-extensions
    cinnamon.nemo-emblems
    cinnamon.nemo-fileroller
    transmission-gtk
 
    # Editors
    gimp 
    inkscape 
    audacity 
    handbrake
    libreoffice-fresh
    meld
    swappy

    # Internet
    discord
    steam
  ];
}
