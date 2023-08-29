{ pkgs, userHome, iconTheme, ... }:
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
      cat $cache | grep -E "^$query" | cut -d' ' -f2
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
      echo $query $best_file >> $cache
      echo $best_file
    fi
  '';
in
{
  home.packages = [ launcher wallpaper random-wallpaper get-wallpapers get-icon ];
  
  programs.eww.package = pkgs.eww-wayland;
  programs.eww.enable = true;
  programs.eww.configDir = ./eww;
}
