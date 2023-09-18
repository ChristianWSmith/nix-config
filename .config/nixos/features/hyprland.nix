{ pkgs, lib, ... }:
{
  programs = {
    gnome-disks.enable = true;
    dconf.enable = true;
    hyprland.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
  hardware = {
    opengl.enable = true;
    bluetooth.enable = true;
  };
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services = {
      gtklock.text = lib.readFile "${pkgs.gtklock}/etc/pam.d/gtklock";
      "christian".enableGnomeKeyring = true;
    };
  };
  services = {
    gnome.gnome-keyring.enable = true;
    udisks2.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
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
    geoclue2.enable = true;
    power-profiles-daemon.enable = true;
  };
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
      };
    };
  };
}
