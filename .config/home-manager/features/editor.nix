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
      :set number relativenumber
      :set tabstop=2
      :set shiftwidth=2
      :set expandtab
      :set autoindent
      :syntax on
    '';
    plugins = [ pkgs.vimPlugins.yuck-vim pkgs.vimPlugins.scss-syntax-vim ];
  };
}
