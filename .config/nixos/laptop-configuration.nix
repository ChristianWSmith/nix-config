{ config, pkgs, lib, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports =
    [
      ./hardware.nix
      ./features/boot.nix
      ./features/keyboard.nix
      ./features/gpu.nix
      ./features/printer.nix
      ./features/locale.nix
      ./features/networking.nix
      ./features/bluetooth.nix
      ./features/users.nix
      ./features/gnome.nix
      # ./features/steam.nix
    ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.05";
}
