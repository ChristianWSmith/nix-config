# TODO: this worked, but fakeSha is a little annoying
# This would also conflict with programs.firefox.settings as written

{ lib, pkgs, user, ... }:
let
  firefoxGnomeTheme = (pkgs.stdenv.mkDerivation rec {
    name = "firefox-gnome-theme";
    src = pkgs.fetchFromGitHub {
      owner  = "rafaelmardojai";
      repo   = "firefox-gnome-theme";
      rev = "master";
      sha256 = "sha256-kWNuxFWEkK2LtxMi3I+L/55dTrAdtCaXyPalClclD8s="; # lib.fakeSha256;
    };  
    buildCommand = ''
      mkdir -p $out
      cp -r $src/* $out/
    '';
  });
in
{
  # TODO: This is kind of just pseudo-dotfile management. Yuck.
  home.file = {
    "${user.home}/.mozilla/firefox/${user.name}/chrome/firefox-gnome-theme/theme".source = "${firefoxGnomeTheme}/theme";
    "${user.home}/.mozilla/firefox/${user.name}/chrome/firefox-gnome-theme/configuration".source = "${firefoxGnomeTheme}/configuration";
    "${user.home}/.mozilla/firefox/${user.name}/chrome/firefox-gnome-theme/userChrome.css".source = "${firefoxGnomeTheme}/userChrome.css";
    "${user.home}/.mozilla/firefox/${user.name}/chrome/firefox-gnome-theme/userContent.css".source = "${firefoxGnomeTheme}/userContent.css";
    "${user.home}/.mozilla/firefox/${user.name}/chrome/userChrome.css".text = ''
      @import "firefox-gnome-theme/userChrome.css"
    '';
    "${user.home}/.mozilla/firefox/${user.name}/chrome/userContent.css".text = ''
      @import "firefox-gnome-theme/userContent.css"
    '';
    "${user.home}/.mozilla/firefox/${user.name}/user.js".source = "${firefoxGnomeTheme}/configuration/user.js";
  };
}
