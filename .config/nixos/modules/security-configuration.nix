{ pkgs, lib, ... }:
{
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services = {
      gtklock.text = lib.readFile "${pkgs.gtklock}/etc/pam.d/gtklock";
      "christian".enableGnomeKeyring = true;
    };
  };
}
