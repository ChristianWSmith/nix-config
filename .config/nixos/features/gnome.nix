{ config, pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };
}
