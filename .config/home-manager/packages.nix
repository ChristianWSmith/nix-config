{ pkgs, user, ... }:
let
  my-python-packages = ps: with ps; [
    psutil
    pygobject3
    xdg
    requests
    (buildPythonPackage rec {
      pname = "pyalsaaudio";
      version = "0.10.0";
      format = "setuptools";
      src = pythonPackages.fetchPypi {
        inherit pname version;
	sha256 = "sha256-4hF1UAor0xCuOGfnmRY53vweKlySzxufcIMpazRnOKs=";
      };
      doCheck = false;
      buildInputs = [ pkgs.alsa-lib ];
    })
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
    profiles."${user.email}".isDefault = true;
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
    blueberry

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
    onlyoffice-bin
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
    gnome.gnome-boxes
  ];
}
