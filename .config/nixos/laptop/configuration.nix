{ config, pkgs, lib, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  fileSystems."/ram" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "size=10M" "mode=777" ];
  };

  imports =
    [
      ./hardware-configuration.nix
      ./gpu-configuration.nix
      ./boot-configuration.nix
      ./services-configuration.nix
      ./security-configuration.nix
      ./locale-configuration.nix
      ./networking-configuration.nix
      ./programs-configuration.nix
      ./users-configuration.nix
      ./printer-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.05";
}
