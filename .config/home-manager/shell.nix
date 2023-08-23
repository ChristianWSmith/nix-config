{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $- == *i* && "$BASH_BYPASS" != "1" ]]
      then
          /${pkgs.fish}/bin/fish
          exit
      else
          unset BASH_BYPASS
          bash_exit () {
            unalias exit
            if [ $# -eq 0 ]
            then
              exit 0
            else
              exit $@
            fi
          }
          alias exit="bash_exit"
      fi
    '';
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    functions = {
      nixosup = "sudo nix-channel --update && sudo nixos-rebuild switch";
      nixup = "nix-channel --update && home-manager switch --impure";
      fullup = "nixosup && nixup";
      ga = "git add $argv";
      gr = "git restore $argv";
      gc = "git commit -m \"$argv\"";
      gp = "git push";
      gs = "git status";
      bash = "BASH_BYPASS=1 /${pkgs.bashInteractive}/bin/bash";
    };
  };
}
