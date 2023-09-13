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

  environment.systemPackages = [
    pkgs.ffmpegthumbnailer
  ];

  environment.pathsToLink = [
    "/share/thumbnailers"
  ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-photos
    gnome.gnome-music
    gnome-connections
    gnome.geary
    gnome.gnome-calendar
    gnome.gnome-contacts
    gnome.totem
    gnome.yelp
    gnome-tour
    epiphany
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };
}
