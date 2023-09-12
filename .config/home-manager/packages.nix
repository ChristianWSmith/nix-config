{ pkgs, inputs, user, ... }:
{
  programs.firefox = {
    enable = true;
    profiles."${user.name}" = {
      extensions = [
        inputs.firefox-addons.packages."x86_64-linux".ublock-origin
        inputs.firefox-addons.packages."x86_64-linux".darkreader
        inputs.firefox-addons.packages."x86_64-linux".vimium
        inputs.firefox-addons.packages."x86_64-linux".new-tab-override
      ];
    };
  };

  programs.git = {
    enable = true;
    userEmail = user.email;
    userName = user.fullName;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  programs.thunderbird = {
    enable = true;
    profiles."${user.email}".isDefault = true;
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = [ 
      pkgs.vscode-extensions.bbenoist.nix 
      pkgs.vscode-extensions.arcticicestudio.nord-visual-studio-code
    ];
  };
  programs.chromium.enable = true;

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
    gamescope
    dconf2nix

    # Media
    vlc
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
 
    # Applications
    obs-studio
    transmission-gtk
    gimp 
    inkscape 
    audacity 
    handbrake
    onlyoffice-bin
    meld
    discord
    steam
  ];
}
