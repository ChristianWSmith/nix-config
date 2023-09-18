{ pkgs, user, ... }:
let
  shellThemeName = "gnome-shell-recolor";
  gnome-shell-recolor = (pkgs.callPackage ./gnome-shell-recolor/default.nix {});
in
{
  home.file = {
    ".local/share/themes/${shellThemeName}/gnome-shell".source = "${gnome-shell-recolor}/";
  };
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [ "user-theme@gnome-shell-extensions.gcampax.github.com" ];
    };
    "org/gnome/shell/extensions/user-theme" = {
      name = shellThemeName;
    };
  };
}
