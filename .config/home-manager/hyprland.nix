{ pkgs, ... }:
let
  launcher = pkgs.writeShellScriptBin "hypr" ''
    #!/${pkgs.bash}/bin/bash
    . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
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
