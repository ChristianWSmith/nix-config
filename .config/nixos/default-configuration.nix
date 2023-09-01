{ config, pkgs, lib, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports =
    [
      ./modules/hardware-configuration-default.nix
      ./modules/display-configuration-default.nix
      ./modules/gpu-configuration-default.nix
      ./modules/boot-configuration.nix
      ./modules/services-configuration.nix
      ./modules/security-configuration.nix
      ./modules/locale-configuration.nix
      ./modules/networking-configuration.nix
      ./modules/programs-configuration.nix
      ./modules/users-configuration.nix
      ./modules/tmpfs-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.05";
}
