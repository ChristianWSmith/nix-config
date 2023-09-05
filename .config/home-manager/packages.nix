{ pkgs, userHome, ... }:
let
  my-python-packages = ps: with ps; [
    psutil
    pygobject3
    xdg
  ];
in
{
  programs.imv = {
    enable = true;
    settings = {
      options.overlay = true;
    };
  };
  programs.thunderbird = {
    enable = true;
    profiles."smith.christian.william@gmail.com".isDefault = true;
  };
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };

  home.packages = with pkgs; [


    # Python
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
    gvfs
    glib
    gdb
    lsof
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
    imagemagick
    jq
    socat

    # Daemon Tools
    xboxdrv

    # TUI Tools
    ranger 
    pulsemixer 
    networkmanager
    vimPlugins.yuck-vim
    khal

    # GUI Tools
    xorg.xrandr
    hyprpaper
    grim
    rofimoji
    slurp 
    wf-recorder
    wl-clipboard 
    cliphist 
    hyprpicker
    inotify-tools
    libnotify
    pavucontrol 
    networkmanagerapplet
    gtklock
    gamescope
    ffmpegthumbnailer
    obs-studio

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

    # GNOME Apps
    gnome.simple-scan
    gnome.cheese
    gnome.gnome-font-viewer
    evince
    # gnome.gnome-calculator
    # gnome.gnome-calendar
    # gnome.gnome-characters
    # gnome.gnome-clocks
    # gnome-connections
    # gnome-usage
    # gnome.eog
    # gnome.gnome-maps
    # gnome.gnome-music
    # gnome.gnome-system-monitor
    # gnome-text-editor
    # gnome.gnome-weather
    # gnome.gnome-notes
    # gnome.gnome-boxes
    # gnome.gnome-nettool
    # gnome.gnome-contacts
    # gnome.gnome-bluetooth
    # gnome.gnome-screenshot
    # gnome.gnome-dictionary
    # gnome.gnome-power-manager
    # gnome.gnome-sound-recorder
    # gnome.gnome-remote-desktop
    # gnome-photos
    # gnome-decoder
    # gnome.totem
  ];
}
