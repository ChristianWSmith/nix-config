{ pkgs, userHome, iconTheme, ... }:
let
  toggleBar = pkgs.writeShellScriptBin "eww-toggle-bar" ''
    if [[ "$(eww windows)" == *"*bar"* ]]
    then
      hyprctl keyword general:gaps_in 0
      hyprctl keyword general:gaps_out 0
      hyprctl keyword general:border_size 0
      hyprctl keyword decoration:rounding 0
      eww close bar
    else
      hyprctl keyword general:gaps_in 3
      hyprctl keyword general:gaps_out 5
      hyprctl keyword general:border_size 1
      hyprctl keyword decoration:rounding 5
      eww open bar
    fi
  '';
  getIcon = pkgs.writeShellScriptBin "get-icon" ''
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
        echo $(readlink -f $best_file)
      fi
    fi
  '';
in
{
  home.packages = [ getIcon toggleBar ];
 
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./eww;
  };
}
