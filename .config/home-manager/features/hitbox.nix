{ pkgs, user, ... }:
let
  hitboxPythonPackages = ps: with ps; [
    pyinotify
  ];

  hitbox = pkgs.writeShellScriptBin "hitbox" ''
    python3 ${user.home}/.assets/hitbox.py
  '';
in
{
  home.packages = with pkgs; [
    (python3.withPackages hitboxPythonPackages)
    hitbox
    xboxdrv
  ];
}

