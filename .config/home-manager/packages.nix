{ pkgs, ... }:
{
  home.packages = with pkgs; [

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
    slurp 
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
    imv 
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

    # Internet
    discord
    steam
  ];
}
