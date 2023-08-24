{ pkgs, ... }:
let
  launcher = pkgs.writeShellScriptBin "eww-launcher" ''
    #!/${pkgs.bash}/bin/bash
    eww daemon
    eww open wallpaper0
    eww open bar
  '';
  wallpaper = pkgs.writeShellScriptBin "eww-wallpaper" ''
    #!/${pkgs.bash}/bin/bash
    ln -sf ''${1} ~/.active-wallpaper
    eww reload
    
  '';
  random-wallpaper = pkgs.writeShellScriptBin "eww-random-wallpaper" ''
    #!/${pkgs.bash}/bin/bash
    ln -sf $(echo ~/.wallpapers/$(ls ~/.wallpapers/ | sort -R | tail -1)) ~/.active-wallpaper
    eww reload
    
  '';
  get-wallpapers = pkgs.writeShellScriptBin "eww-get-wallpapers" ''
    #!/${pkgs.bash}/bin/bash
    wget -nc -O ~/.config/home-manager/files/wallpapers/god.jpeg i.imgur.com/hAwDl3p.jpeg
    wget -nc -O ~/.config/home-manager/files/wallpapers/nature.png i.imgur.com/tgAaO3G.png
    
  '';
in
{
  home.packages = [ launcher wallpaper random-wallpaper get-wallpapers ];
  
  programs.eww.package = pkgs.eww-wayland;
  programs.eww.enable = true;
  programs.eww.configDir = ./eww;
}
