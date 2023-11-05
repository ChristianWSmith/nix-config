{ inputs, pkgs, user, theme, ... }:
let
  pythonPackages = ps: with ps; [
    matplotlib
    pyinotify
  ];

  pythonPackage = pkgs.python3.withPackages pythonPackages;
in
{ 
  programs.git = {
    enable = true;
    userEmail = user.email;
    userName = user.fullName;
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "Default";
      theme_background = false;
    };
  };
  
  programs.imv = {
    enable = true;
    settings = {
      options.overlay = true;
    };
  };
  programs.thunderbird = {
    enable = true;
    profiles."${user.email}".isDefault = true;
  };
  
  home.packages = with pkgs; [
    # Fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif

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
    ghostscript
    jq
    socat
    pythonPackage

    # TUI Tools
    pulsemixer 
    networkmanager
    # khal

    # GUI Tools
    xorg.xrandr
    rofimoji
    wf-recorder
    wl-clipboard 
    cliphist 
    hyprpicker
    inotify-tools
    libnotify
    pavucontrol 
    networkmanagerapplet
    gamescope
    ffmpegthumbnailer
    obs-studio
    blueberry

    # Files
    mpv
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
    onlyoffice-bin
    meld
    galculator
    libsForQt5.kdenlive
    obsidian

    # Internet
    discord

    # GNOME Apps
    gnome.simple-scan
    gnome.cheese
    gnome.gnome-font-viewer
    evince
    gnome.gnome-boxes

    yed
    (callPackage ../packages/hyprprop.nix {})
  ];
}
