{ pkgs, ... }:
let
  myUtsushi = pkgs.utsushi.override { withNetworkScan = true; };
  myPatchedUtsushi = myUtsushi.overrideAttrs (oldAttrs: {
        postInstall = oldAttrs.postInstall or "" + ''
            echo "[devices]"                                               > $out/etc/utsushi/utsushi.conf
            echo "myscanner.udi    = esci:networkscan://192.168.1.2:1865" >> $out/etc/utsushi/utsushi.conf
            echo "myscanner.vendor = Epson"                               >> $out/etc/utsushi/utsushi.conf
            echo "myscanner.model  = ET-3830 Series"                      >> $out/etc/utsushi/utsushi.conf
        '';
      });
in
{
  services = {
    udev.packages = [ 
      myPatchedUtsushi
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
    extraBackends = [ myPatchedUtsushi ];
  };
}
