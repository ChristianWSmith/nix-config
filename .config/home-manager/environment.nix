{ pkgs, ... }:
{
  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "firefox";
    TERMINAL = "footclient";
    NIXPKGS_ALLOW_UNFREE = "1";
    SHELL = "${pkgs.fish}/bin/fish";
  };
}
