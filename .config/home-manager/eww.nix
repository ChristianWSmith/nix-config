{ pkgs, userHome, iconTheme, ... }:
let
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
  home.packages = [ get-icon toggle-bar ];
 
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./eww;
  };
}
