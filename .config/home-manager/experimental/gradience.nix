# TODO: this didn't work great because generated color themes resulted
# in firefox having a transparent top bar

{ pkgs, lib, user, ... }:
let
  # TODO: If I want to use master branch
  # gradience = pkgs.gradience.overrideAttrs (old: {
  #   version = "git";
  #   src = pkgs.fetchFromGitHub {
  #     fetchSubmodules = true;
  #     owner = "GradienceTeam";
  #     repo = "Gradience";
  #     rev = "4f0a9ebc6dcd3fe6c3355f01482d450c9a0e144f";
  #     sha256 = "sha256-TCNTD0/EqAnLSSHFrFa/HLpl4tez3e64TjNJky0GBEU=";
  #   };
  # });
  gradience = (pkgs.callPackage ./gradience-package.nix {});
  # gradience = pkgs.gradience;

  autoGradience = pkgs.writeShellApplication {
    name = "auto-gradience";
    runtimeInputs = [ gradience pkgs.gnome.zenity pkgs.dbus ];
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
        PROMPT_LOGOUT="false"
      else
        gradience-cli monet --preset-name "$SHA256" --image-path "$WALLPAPER" --theme "$THEME"
        PROMPT_LOGOUT="true"
      fi
      MONET=$(gradience-cli presets | grep "$SHA256" | sed "s@.*-> \(.*\)@\1@g")
      if ! [ -f "$MONET" ]; then
        echo "Monet file does not exist $MONET"
        exit 1
      fi
      mkdir -p ${user.home}/.mozilla/firefox/${user.name}/chrome/firefox-gnome-theme/
      gradience-cli apply --preset-name "$SHA256" --gtk both
      if [ "$PROMPT_LOGOUT" = "true" ]; then
        if zenity --question --title="Logout Now?" --text="Logout necessary to apply Gradience colors." --ok-label=Yes --cancel-label=No; then
          dbus-send --session --type=method_call --print-reply --dest=org.gnome.SessionManager /org/gnome/SessionManager org.gnome.SessionManager.Logout uint32:1
        fi
      fi
    '';
  };
in
{
  dconf.settings = {
    "com/github/GradienceTeam/Gradience" = {
      enabled-plugins = [ "firefox_gnome_theme" ];
      user-flatpak-theming-gtk3 = true;
      user-flatpak-theming-gtk4 = true;
    };
  };
  home.packages = [pkgs.gradience autoGradience];
}
