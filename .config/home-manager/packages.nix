{ pkgs, ... }:

{
  home.packages = with pkgs; [

    # Shells
    fish

    # nixGL
    nixgl.auto.nixGLDefault
    # pkgs.nixgl.auto.nixGLNvidia
    # pkgs.auto.nixGLNvidiaBumblebee
    # pkgs.nixGLIntel

    # Command Line Tools
    # rar unrar zip unzip p7zip

    # Daemon Tools
    # xboxdrv

    # TUI Tools
    vim
    # ranger btop pulsemixer networkmanager

    # GUI Tools
    # grim
    # slurp
    # hyprpicker

    # 
    # imv mpv
    # cinnamon.nemo
    
    # 
    # steam discord
    firefox 

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
