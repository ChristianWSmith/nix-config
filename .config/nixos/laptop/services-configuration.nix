{ lib, ... }:
{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
  services.keyd.enable = true;
  services.keyd.keyboards.default = {
    ids = [ "*" ];
    settings.main = {
      alt = "layer(meta)";
      meta = "layer(alt)";
    };
  };
  services.getty = {
    autologinUser = "christian";
    helpLine = lib.mkForce "";
    greetingLine = "";
    extraArgs = [ "--skip-login" ];
  };
}
