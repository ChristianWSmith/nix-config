{ pkgs, user, ... }:
let
  hitbox = pkgs.writeShellScriptBin "hitbox" ''
    ${user.home}/.assets/hitbox.py ${pkgs.xboxdrv}/bin/xboxdrv
  '';
in
{
  home.packages = with pkgs; [
    hitbox
    xboxdrv
  ];
  systemd.user.services.hitbox = {
    Unit = {
      Description = "DragonRise PCB Hitbox Daemon";
    };
    Service = {
      Type = "simple";
      ExecStart = "${user.home}/.nix-profile/bin/hitbox";
      Restart = "on-failure";
      RestartSec = 1;
    };
  };
}

