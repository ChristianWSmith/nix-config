{ pkgs, user, ... }:
let
  hitboxPythonPackages = ps: with ps; [
    pyinotify
  ];

  pythonPackage = pkgs.python3.withPackages hitboxPythonPackages;

  hitbox = pkgs.writeShellScriptBin "hitbox" ''
    ${pythonPackage}/bin/python ${user.home}/.assets/hitbox.py ${pkgs.xboxdrv}/bin/xboxdrv
  '';
in
{
  home.packages = with pkgs; [
    pythonPackage
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

