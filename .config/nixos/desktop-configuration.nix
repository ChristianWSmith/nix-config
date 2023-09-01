{ config, pkgs, lib, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports =
    [
      ./modules/hardware-configuration-desktop.nix
      ./modules/display-configuration-desktop.nix
      ./modules/gpu-configuration.nix
      ./modules/boot-configuration.nix
      ./modules/services-configuration.nix
      ./modules/security-configuration.nix
      ./modules/locale-configuration.nix
      ./modules/networking-configuration.nix
      ./modules/programs-configuration.nix
      ./modules/users-configuration.nix
      ./modules/printer-configuration.nix
      ./modules/tmpfs-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.05";
}