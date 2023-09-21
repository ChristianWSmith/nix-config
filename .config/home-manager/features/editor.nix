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
    extraConfig = ''
      nmap i <Up>
      nmap j <Left>
      nmap k <Down>
      nmap l <Right>
      nmap h <Insert>
    '';
    plugins = [ pkgs.vimPlugins.yuck-vim pkgs.vimPlugins.scss-syntax-vim ];
  };
}
