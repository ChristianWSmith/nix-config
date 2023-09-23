{ pkgs, lib, ... }:
let
  portalPackages = [ pkgs.xdg-desktop-portal pkgs.xdg-desktop-portal-hyprland ];
  joinedPortals = pkgs.buildEnv {
    name = "xdg-portals";
    paths = portalPackages;
    pathsToLink = [ "/share/xdg-desktop-portal/portals" "/share/applications" ];
  };
in
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
    enable = lib.mkForce false;
    extraPortals = lib.mkForce [ ];
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
    dbus.packages = portalPackages;
  };
  environment = {
    systemPackages = [ joinedPortals ];
    pathsToLink = [ "/share/applications" ];
    sessionVariables = {
      XDG_DESKTOP_PORTAL_DIR = "${joinedPortals}/share/xdg-desktop-portal/portals";
    };
  };
  systemd = {
    packages = portalPackages; 
    user.services.xdg-desktop-portal = {
      description = "Portal service";
      partOf = lib.mkForce [];
      serviceConfig = {
        Type = "dbus";
        BusName = "org.freedesktop.portal.Desktop";
        ExecStart = "${pkgs.xdg-desktop-portal}/libexec/xdg-desktop-portal";
        Slice = "session.slice";
      };
    };
    user.services.xdg-desktop-portal-hyprland = {
      description = "Portal service (Hyprland implementation)";
      partOf = lib.mkForce [];
      after = lib.mkForce [];
      serviceConfig = {
        Type = "dbus";
        BusName = "org.freedesktop.impl.portal.desktop.hyprland";
        ExecStart = "${pkgs.xdg-desktop-portal-hyprland}/libexec/xdg-desktop-portal-hyprland";
        Restart = "on-failure";
        Slice = "session.slice";
      };
    };
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
