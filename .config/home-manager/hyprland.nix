{ pkgs, ... }:
let
  launcher = pkgs.writeShellScriptBin "hypr" ''
    #!/${pkgs.bash}/bin/bash

    . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

    export GDK_BACKEND=wayland,x11
    export QT_QPA_PLATFORM="wayland;xcb"
    export SDL_VIDEODRIVER=wayland
    export CLUTTER_BACKEND=wayland
    export XDG_CURRENT_DESKTOP=Hyprland
    export XDG_SESSION_TYPE=wayland
    export XDG_SESSION_DESKTOP=Hyprland
    export QT_AUTO_SCREEN_SCALE_FACTOR=1
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export QT_QPA_PLATFORMTHEME=qt5ct
    export GTK_THEME=Adwaita
    export XCURSOR_THEME=Adwaita
    export XCURSOR_SIZE=40
    
    # NVIDIA
    # export GBM_BACKEND=nvidia-drm
    # export __GLX_VENDOR_LIBRARY_NAME=nvidia
    # export LIBVA_DRIVER_NAME=nvidia
    # export __GL_GSYNC_ALLOWED=0
    # export __GL_VRR_ALLOWED=0
    # export WLR_DRM_NO_ATOMIC=1

    nixGL ${pkgs.hyprland}/bin/Hyprland
  '';
in
{
  home.packages = [ launcher ];
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      source=~/.config/hypr/binds.conf
      source=~/.config/hypr/autoexec.conf
      source=~/.config/hypr/windowrules.conf
      source=~/.config/hypr/input.conf
      source=~/.config/hypr/appearance.conf
      source=~/.config/hypr/environment.conf 
    '';
  };
}
