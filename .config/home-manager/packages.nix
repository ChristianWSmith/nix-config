{ pkgs, inputs, user, userHome, userFullName, userEmail, ... }:
{
  programs.firefox = {
    enable = true;
    profiles."${user}" = {
      extensions = [
        inputs.firefox-addons.packages."x86_64-linux".ublock-origin
        inputs.firefox-addons.packages."x86_64-linux".darkreader
      ];
    };
  };

  programs.git = {
    enable = true;
    userEmail = userEmail;
    userName = userFullName;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  programs.thunderbird = {
    enable = true;
    profiles."${userEmail}".isDefault = true;
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };

  home.packages = with pkgs; [
    # Shells
    bashInteractive

    # CLI Fun
    yafetch

    # Command Line Tools
    rar 
    zip 
    unzip 
    p7zip

    # GUI Tools
    ffmpegthumbnailer
    gamescope
    obs-studio

    # Files
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

    # Internet
    discord
    steam
  ];
}
