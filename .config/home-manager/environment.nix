{ pkgs, ... }:
{
  home.sessionVariables = {
    SHELL = "${pkgs.fish}/bin/fish";
    TERMINAL = "footclient";
    BROWSER = "firefox";
    NIXPKGS_ALLOW_UNFREE = "1";
  };
}
