{ pkgs, ... }:
let
  utsushi = (pkgs.utsushi.override { withNetworkScan = true; }).overrideAttrs (oldAttrs: {
    postInstall = oldAttrs.postInstall or "" + ''
      rm -f $out/etc/utsushi/utsushi.conf
      tee -a $out/etc/utsushi/utsushi.conf << EOF
      [devices]
      myscanner.udi    = esci:networkscan://192.168.1.2:1865
      myscanner.vendor = Epson
      myscanner.model  = ET-3830 Series
      EOF
    '';
  });
in
{
  services = {
    udev.packages = [ 
      utsushi
    ];
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
  hardware.sane = {
    enable = true;
    extraBackends = [ utsushi ];
  };
}
