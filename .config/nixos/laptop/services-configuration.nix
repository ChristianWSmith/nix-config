{ pkgs, lib, ... }:
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
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    xserver = {
      layout = "us";
      xkbVariant = "";
    };
    keyd = {
      enable = true;
      keyboards.default = {
        ids = [ "*" ];
        settings.main = {
          alt = "layer(meta)";
          meta = "layer(alt)";
        };
      };
    };
    getty = {
      autologinUser = "christian";
      helpLine = lib.mkForce "";
      greetingLine = "";
      extraArgs = [ "--skip-login" ];
    };
    udev.packages = [ 
      myPatchedUtsushi
    ];
    avahi = {
      enable = true;
      nssmdns = true;
    };
    power-profiles-daemon.enable = true;
  };
  hardware.sane = {
    enable = true;
    extraBackends = [ myPatchedUtsushi ];
  };
}
