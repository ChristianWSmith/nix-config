{ pkgs, userHome, iconTheme, ... }:
let
  launcher = pkgs.writeShellScriptBin "eww-wallpaper-launcher" ''
    if ! [ -f ${userHome}/.active-wallpaper ]
    then
      ln -sf ${userHome}/.wallpapers/default.jpg ${userHome}/.active-wallpaper
    fi
    ${pkgs.eww-wayland}/bin/eww close wallpaper
    for monitor in $(hyprctl monitors -j | jq '.[].id')
    do
      ${pkgs.eww-wayland}/bin/eww open wallpaper$monitor
    done
  '';
  wallpaper = pkgs.writeShellScriptBin "eww-set-wallpaper" ''
    ln -sf $(readlink -f $1) ${userHome}/.active-wallpaper
    eww-wallpaper-launcher
  '';
  random-wallpaper = pkgs.writeShellScriptBin "eww-random-wallpaper" ''
    ln -sf $(echo ${userHome}/.wallpapers/$(ls ${userHome}/.wallpapers/ | sort -R | tail -1)) ${userHome}/.active-wallpaper
    eww-wallpaper-launcher
  '';
  get-wallpapers = pkgs.writeShellScriptBin "eww-get-wallpapers" ''
    wallpaper_dir=${userHome}/.config/home-manager/files/wallpapers
    got_wallpapers=${userHome}/.got-wallpapers
    if [ -f $got_wallpapers ]
    then
      exit
    fi
    # wget -nc -O $wallpaper_dir/<image_name> <url>
    touch $got_wallpapers
  '';
  toggle-bar = pkgs.writeShellScriptBin "eww-toggle-bar" ''
    if [ "$(${pkgs.eww-wayland}/bin/eww windows | grep \*bar)" ]
    then
      ${pkgs.eww-wayland}/bin/eww close bar
    else
      ${pkgs.eww-wayland}/bin/eww open bar
    fi
  '';
  get-icon = pkgs.writeShellScriptBin "get-icon" ''
    cache_dir=${userHome}/.get-icon-cache
    cache=$cache_dir/${iconTheme}
    icon_dir=${userHome}/.nix-profile/share/icons/${iconTheme}
    query=$1

    if ! [ -d $cache_dir ]
    then
      mkdir -p $cache_dir
    fi

    if ! [ -f $cache ]
    then
      touch $cache
    fi
    if [ "$(cat $cache | grep -E "^$query ")" ]
    then
      cat $cache | grep -E "^$query " | cut -d' ' -f2
    else
      best_resolution=0
      best_file=""
      for file in $(find -L "$icon_dir/" -type f -name "$query.*")
      do
        resolution=$(("$(identify $file | cut -d' ' -f3 | sed 's/x/*/g')"))
        if [[ $resolution -gt $best_resolution ]]
        then
          best_resolution=$resolution
          best_file=$file
        fi
      done
      if [ "$best_file" != "" ]
      then
        echo $query $best_file >> $cache
        readlink -f $best_file
      fi
    fi
  '';
in
{
  home.packages = [ launcher wallpaper random-wallpaper get-wallpapers get-icon toggle-bar ];
 
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./eww;
  };
}
