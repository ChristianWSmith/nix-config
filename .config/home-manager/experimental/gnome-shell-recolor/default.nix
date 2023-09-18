{ pkgs, stdenv, lib }: 
let
  version = "2023-09-15";
in
  stdenv.mkDerivation {
    pname = "gnome-shell-recolor";
    inherit version;

    # TODO: this seems undoable because gnome-shell.css doesn't use named colors
    # so there's no way to know if you're replacing accent_fg_color or success_fg_color
    accent_color = "#78aeed";
    accent_bg_color = "#3584e4";
    accent_fg_color = "#ffffff";
    destructive_color = "#ff7b63";
    destructive_bg_color = "#c01c28";
    destructive_fg_color = "#ffffff";
    success_color = "#8ff0a4";
    success_bg_color = "#26a269";
    success_fg_color = "#ffffff";
    warning_color = "#f8e45c";
    warning_bg_color = "#cd9309";
    warning_fg_color = "rgba(0, 0, 0, 0.8)";
    error_color = "#ff7b63";
    error_bg_color = "#c01c28";
    error_fg_color = "#ffffff";
    window_bg_color = "#242424";
    window_fg_color = "#ffffff";
    view_bg_color = "#1e1e1e";
    view_fg_color = "#ffffff";
    headerbar_bg_color = "#303030";
    headerbar_fg_color = "#ffffff";
    headerbar_border_color = "#ffffff";
    headerbar_backdrop_color = "#242424";
    headerbar_shade_color = "rgba(0, 0, 0, 0.36)";
    card_bg_color = "rgba(255, 255, 255, 0.08)";
    card_fg_color = "#ffffff";
    card_shade_color = "rgba(0, 0, 0, 0.36)";
    dialog_bg_color = "#383838";
    dialog_fg_color = "#ffffff";
    popover_bg_color = "#383838";
    popover_fg_color = "#ffffff";
    shade_color = "rgba(0, 0, 0, 0.36)";
    scrollbar_outline_color = "rgba(0, 0, 0, 0.5)";
    blue_1 = "#99c1f1";
    blue_2 = "#62a0ea";
    blue_3 = "#3584e4";
    blue_4 = "#1c71d8";
    blue_5 = "#1a5fb4";
    green_1 = "#8ff0a4";
    green_2 = "#57e389";
    green_3 = "#33d17a";
    green_4 = "#2ec27e";
    green_5 = "#26a269";
    yellow_1 = "#f9f06b";
    yellow_2 = "#f8e45c";
    yellow_3 = "#f6d32d";
    yellow_4 = "#f5c211";
    yellow_5 = "#e5a50a";
    orange_1 = "#ffbe6f";
    orange_2 = "#ffa348";
    orange_3 = "#ff7800";
    orange_4 = "#e66100";
    orange_5 = "#c64600";
    red_1 = "#f66151";
    red_2 = "#ed333b";
    red_3 = "#e01b24";
    red_4 = "#c01c28";
    red_5 = "#a51d2d";
    purple_1 = "#dc8add";
    purple_2 = "#c061cb";
    purple_3 = "#9141ac";
    purple_4 = "#813d9c";
    purple_5 = "#613583";
    brown_1 = "#cdab8f";
    brown_2 = "#b5835a";
    brown_3 = "#986a44";
    brown_4 = "#865e3c";
    brown_5 = "#63452c";
    light_1 = "#ffffff";
    light_2 = "#f6f5f4";
    light_3 = "#deddda";
    light_4 = "#c0bfbc";
    light_5 = "#9a9996";
    dark_1 = "#77767b";
    dark_2 = "#5e5c64";
    dark_3 = "#3d3846";
    dark_4 = "#241f31";
    dark_5 = "#000000";

    sourceRoot = ".";

    buildInputs = with pkgs; [
      glib
      busybox
    ];

    srcs = [
      "${pkgs.gnome.gnome-shell}/"
      ./recolor.sh
    ];

    unpackPhase = ''
      for src in $srcs; do
        if [[ "$src" == *"gnome-shell"* ]]; then
          cp $src/share/gnome-shell/gnome-shell-theme.gresource .
        else
          cp -r $src $(basename $src | cut -d'-' -f2-)
        fi
      done
    '';

    buildPhase = ''
      mkdir -p out
      for file in $(gresource list gnome-shell-theme.gresource); do
        gresource extract gnome-shell-theme.gresource "$file" > out/$(basename "$file")
      done
      ls recolor.sh
    '';

    installPhase = ''
      mkdir -p $out
      cp -r ./out/* $out/
    '';

    meta = with lib; {
      description = "GNOME Shell Recolor";
      platforms = platforms.linux;
    };
  }
