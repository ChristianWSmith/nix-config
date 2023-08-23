{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    functions = {
      nixosup = "sudo nixos-rebuild switch";
      nixup = "nix-channel --update && home-manager switch --impure";
      ga = "git add $argv";
      gr = "git restore $argv";
      gc = "git commit -m \"$argv\"";
      gp = "git push";
      gs = "git status";
    };
  };
}
