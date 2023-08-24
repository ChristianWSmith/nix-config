{ pkgs, ... }:
let
  launcher = pkgs.writeShellScriptBin "hyprland-launcher" ''
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
    export XCURSOR_THEME=Adwaita
    export XCURSOR_SIZE=40

    # export QT_QPA_PLATFORM="wayland;xcb"
    # export QT_QPA_PLATFORMTHEME=qt5ct
    # export QT_PLUGINS_PATH=/usr/lib/qt/plugins/
    # export XDG_CURRENT_DESKTOP=hyprland
    # export XDG_CONFIG_HOME=$HOME/.config
    # export TUI_VOLUME_CONTROL=pulsemixer
    # export GUI_VOLUME_CONTROL=pavucontrol

    # NVIDIA
    # export GBM_BACKEND=nvidia-drm
    # export __GLX_VENDOR_LIBRARY_NAME=nvidia
    # export LIBVA_DRIVER_NAME=nvidia
    # export __GL_GSYNC_ALLOWED=0
    # export __GL_VRR_ALLOWED=0
    # export WLR_DRM_NO_ATOMIC=1

    OS=$(cat /etc/os-release | grep -e "^NAME=" | sed s/NAME=//g)

    if [[ "$OS" == "NixOS" ]]
    then
      # ${pkgs.hyprland}/bin/Hyprland # TODO: uncomment this once distro-independence is reached
      nixGL ${pkgs.hyprland}/bin/Hyprland
    else
      nixGL ${pkgs.hyprland}/bin/Hyprland
    fi
  '';
  enableScreenSharing = pkgs.writeShellScriptBin "hyprland-enable-screen-sharing" ''
    #!/${pkgs.bash}/bin/bash

    systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    dbus-update-activation-environment
    dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    systemctl --user start xdg-desktop-portal
    systemctl --user start xdg-desktop-portal-hyprland
  '';
  screenshot = pkgs.writeShellScriptBin "hyprland-screenshot" ''
    #!/${pkgs.bash}/bin/bash
    dimensions="$(slurp -d)"
    if [ "$dimensions" ]
    then
        grim -g "$dimensions" - | wl-copy
        notify-send -t 5000 "Screenshot copied to clipboard."
    else
        notify-send -t 5000 "Screenshot canceled."
    fi
  '';
in
{
  home.packages = [ launcher screenshot enableScreenSharing ];
  services.clipman = {
    enable = true;
    systemdTarget = "hyprland-session.target";
  };
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig = ''
      source=~/.config/hypr/appearance.conf
      source=~/.config/hypr/autoexec.conf
      source=~/.config/hypr/input.conf
      source=~/.config/hypr/binds.conf
      source=~/.config/hypr/windowrules.conf
      source=~/.config/hypr/environment.conf 
    '';
  };
}
