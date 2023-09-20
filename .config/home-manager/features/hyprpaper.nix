{ user, pkgs, ... }:
let
  setWallpaper = pkgs.writeShellScriptBin "set-wallpaper" ''
    ln -sf $(readlink -f $1) ${user.home}/.active-wallpaper
    pkill hyprpaper
    hyprpaper
  '';
  randomWallpaper = pkgs.writeShellScriptBin "random-wallpaper" ''
    ln -sf $(echo ${user.home}/.wallpapers/$(ls ${user.home}/.wallpapers/ | sort -R | tail -1)) ${user.home}/.active-wallpaper
    pkill hyprpaper
    hyprpaper
  '';
  getWallpapers = pkgs.writeShellScriptBin "get-wallpapers" ''
    wallpaper_dir=${user.home}/.wallpapers
    got_wallpapers=${user.home}/.got-wallpapers
    if [ -f $got_wallpapers ]
    then
      exit
    fi
    wget -nc -O $wallpaper_dir/garden.png https://tinyurl.com/26ey564k
    touch $got_wallpapers
  '';
in
{
  home.packages = [ pkgs.hyprpaper setWallpaper randomWallpaper getWallpapers ];
  home.file = {
    ".config/hypr/hyprpaper.conf".text = ''
      preload = ~/.active-wallpaper

      wallpaper = eDP-1,~/.active-wallpaper
      wallpaper = DP-1,~/.active-wallpaper
      wallpaper = DP-2,~/.active-wallpaper
      wallpaper = DP-3,~/.active-wallpaper
    '';
  };

}
