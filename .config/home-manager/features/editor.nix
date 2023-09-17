{ pkgs, ... }:
let
  editor = pkgs.writeShellScriptBin "editor" ''
    neovim $@
  '';
in
{
  home.packages = [ editor ];
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    plugins = [ pkgs.vimPlugins.yuck-vim pkgs.vimPlugins.scss-syntax-vim ];
  };
}
