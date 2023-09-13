{ pkgs, ... }:
let
  autoGradience = pkgs.writeShellApplication {
    name = "auto-gradience";
    runtimeInputs = [ pkgs.gradience ];
    text = ''
      COLOR_SCHEME=$(dconf read /org/gnome/desktop/interface/color-scheme)
      echo "Color scheme is: $COLOR_SCHEME"
      if [ "$COLOR_SCHEME" = "'default'" ]; then
        THEME="light"
        WALLPAPER=$(dconf read /org/gnome/desktop/background/picture-uri | sed "s@'@@g" | sed "s@file://@@g")
      elif [ "$COLOR_SCHEME" = "'prefer-dark'" ]; then
        THEME="dark"
        WALLPAPER=$(dconf read /org/gnome/desktop/background/picture-uri-dark | sed "s@'@@g" | sed "s@file://@@g")
      else
        echo "Invalid value of /org/gnome/desktop/interface/color-scheme: $COLOR_SCHEME"
        exit 1
      fi
      echo "Wallpaper is $WALLPAPER"
      if [ -f "$WALLPAPER" ]; then
        SHA256="$(sha256sum "$WALLPAPER" | awk '{ print $1 }')-$THEME"
      else
        echo "Wallpaper does not exist: $WALLPAPER"
        exit 1
      fi
      echo "SHA256 is $SHA256"
      if gradience-cli presets | grep "$SHA256"; then
        echo "Monet already exists for SHA256: $SHA256"
        exit 0
      fi
      gradience-cli monet --preset-name "$SHA256" --image-path "$WALLPAPER" --theme "$THEME"
      MONET=$(gradience-cli presets | grep "$SHA256" | sed "s@.*-> \(.*\)@\1@g")
      if ! [ -f "$MONET" ]; then
        echo "Monet file does not exist $MONET"
        exit 1
      fi
      gradience-cli flatpak-overrides -e both
      gradience-cli apply --preset-name "$SHA256" --gtk both
    '';
  };
in
{
  home.packages = [pkgs.gradience autoGradience];
}