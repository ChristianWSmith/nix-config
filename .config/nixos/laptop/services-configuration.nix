{ pkgs, lib, ... }:
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
    power-profiles-daemon.enable = true;
  };
}
