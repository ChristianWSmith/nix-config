{ pkgs, lib, ... }:
{
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.pam.services.gtklock.text = lib.readFile "${pkgs.gtklock}/etc/pam.d/gtklock";
  security.pam.services."christian".enableGnomeKeyring = true;
}
