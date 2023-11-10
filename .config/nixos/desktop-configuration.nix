{ config, pkgs, lib, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = [
    ./hardware.nix
    ./features/display-desktop.nix
    ./features/gpu-amd.nix
    ./features/boot.nix
    ./features/locale.nix
    ./features/networking.nix
    ./features/users.nix
    ./features/printer.nix
    ./features/hyprland.nix
    ./features/virtualization.nix
  ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.05";
}
