{ pkgs, ... }:
{
  services = {
    avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
    };
    printing = {
      enable = true;
      drivers = [ pkgs.epson-escpr2 ];
    };
  };
  hardware.sane.enable = true;
}
