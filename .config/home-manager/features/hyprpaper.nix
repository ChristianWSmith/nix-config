{ pkgs, ... }:
{
  home.packages = [ pkgs.hyprpaper ];
  home.file = {
    ".config/hypr/hyprpaper.conf".text = ''
      preload = ~/.assets/wallpaper.png

      wallpaper = eDP-1,~/.assets/wallpaper.png
      wallpaper = DP-1,~/.assets/wallpaper.png
      wallpaper = DP-2,~/.assets/wallpaper.png
      wallpaper = DP-3,~/.assets/wallpaper.png
    '';
  };

}