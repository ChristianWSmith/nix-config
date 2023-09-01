{ config, pkgs, lib, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports =
    [
      ./hardware-configuration.nix
      ./display-configuration.nix
      ./gpu-configuration.nix
      ./boot-configuration.nix
      ./services-configuration.nix
      ./security-configuration.nix
      ./locale-configuration.nix
      ./networking-configuration.nix
      ./programs-configuration.nix
      ./users-configuration.nix
      ./printer-configuration.nix
      ./tmpfs-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.05";
}
