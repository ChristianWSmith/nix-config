{ user, pkgs, ... }:
let
  setWallpaper = pkgs.writeShellScriptBin "set-wallpaper" ''
    ln -sf $(readlink -f $1) ${user.home}/.active-wallpaper
    pkill hyprpaper
    hyprpaper
  '';
  randomWallpaper = pkgs.writeShellScriptBin "random-wallpaper" ''
    current_wallpaper=$(basename $(readlink ${user.home}/.active-wallpaper))

    if [ "$current_wallpaper" = "" ]; then
      new_wallpaper=$(ls ${user.home}/.wallpapers | sort -R | tail -1)
    else
      new_wallpaper=$(ls ${user.home}/.wallpapers | grep -v $current_wallpaper | sort -R | tail -1)
    fi

    if [ "$new_wallpaper" = "" ]; then
      new_wallpaper="${user.home}/.wallpapers/default.png"
    else
      new_wallpaper="${user.home}/.wallpapers/$new_wallpaper"
    fi

    ln -sf $new_wallpaper ${user.home}/.active-wallpaper
    pkill hyprpaper
    hyprpaper
  '';
  getWallpapers = pkgs.writeShellScriptBin "get-wallpapers" ''
    wallpaper_dir=${user.home}/.wallpapers
    got_wallpapers=${user.home}/.got-wallpapers

    CURRENT_SHA=$(sha256sum $(readlink -f $0) | cut -d' ' -f1)
    LAST_SHA=$(cat $got_wallpapers)

    if [ "$CURRENT_SHA" != "$LAST_SHA" ]; then
      echo "Updating wallpapers..."
    else
      echo "Wallpapers up to date."
      exit
    fi

    download() {
      wget -nc -O $wallpaper_dir/$1 $2
    }

    download beach-gate.jpg https://tinyurl.com/2p9dfrb2
    download garden.png https://tinyurl.com/26ey564k
    echo "$CURRENT_SHA" > $HOME/.got-wallpapers
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
