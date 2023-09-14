{ lib, pkgs, user, ... }:
let
  firefoxGnomeTheme = (pkgs.stdenv.mkDerivation rec {
    name = "firefox-gnome-theme";
    src = pkgs.fetchFromGitHub {
      owner  = "rafaelmardojai";
      repo   = "firefox-gnome-theme";
      rev = "master";
      sha256 = "sha256-D3wgXerkZgl2fS2HpqTsO+Z/EoqAqFIijN07wjbY+7U="; # lib.fakeSha256;
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
    "${user.home}/.mozilla/firefox/${user.name}/chrome/firefox-gnome-theme".source = "${firefoxGnomeTheme}/";
    "${user.home}/.mozilla/firefox/${user.name}/chrome/userChrome.css".text = ''
      @import "firefox-gnome-theme/userChrome.css"
    '';
    "${user.home}/.mozilla/firefox/${user.name}/chrome/userContent.css".text = ''
      @import "firefox-gnome-theme/userContent.css"
    '';
    "${user.home}/.mozilla/firefox/${user.name}/user.js".source = "${firefoxGnomeTheme}/configuration/user.js";
  };
}
