{ pkgs, ... }:
let
  launcher = pkgs.writeShellApplication { # TODO: convert everything to writeShellApplication!!
    name = "eww-launcher";
    runtimeInputs = [ pkgs.eww-wayland pkgs.jq pkgs.hyprland ];
    text = ''
      if pgrep -f "eww daemon" > /dev/null
      then
        pkill -f "eww daemon"
      fi
      eww daemon
      for monitor in $(hyprctl monitors -j | jq '.[].id')
      do
        eww open wallpaper --screen "$monitor"
      done
      eww open bar
    '';
  };

  wallpaper = pkgs.writeShellScriptBin "eww-wallpaper" ''
    ln -sf ''${1} ~/.active-wallpaper
    eww reload
    
  '';
  random-wallpaper = pkgs.writeShellScriptBin "eww-random-wallpaper" ''
    ln -sf $(echo ~/.wallpapers/$(ls ~/.wallpapers/ | sort -R | tail -1)) ~/.active-wallpaper
    eww reload
    
  '';
  get-wallpapers = pkgs.writeShellScriptBin "eww-get-wallpapers" ''
    wget -nc -O ~/.config/home-manager/files/wallpapers/god.jpeg i.imgur.com/hAwDl3p.jpeg
    
  '';
in
{
  home.packages = [ launcher wallpaper random-wallpaper get-wallpapers ];
  
  programs.eww.package = pkgs.eww-wayland;
  programs.eww.enable = true;
  programs.eww.configDir = ./eww;
}
