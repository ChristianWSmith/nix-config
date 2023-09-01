{ pkgs, userHome, ... }:
{
  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $- == *i* ]] && [[ "$BASH_BYPASS" != "1" ]] && [[ "$buildCommandPath" != *"nix-shell"* ]]
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
      if test (tty) = /dev/tty1;
        while test -f ~/.tty1-gui-only;
          hyprland-launcher;
        end;
      else;
        yafetch;
      end;
    '';
    functions = {
      nixos-up = "sudo nix-channel --update && sudo nixos-rebuild switch";
      nix-up = "cd && nix-channel --update && home-manager switch -b backup --impure && cd -";
      flake-up = "nix flake update ${userHome}/.config/home-manager/";
      full-up = "nixos-up && nix-up";
      nixos-flash = ''
        if test -d ~/.config/nixos/$argv && count $argv > /dev/null;
          :;
        else;
          echo No such NixOS config: \"$argv\", available: $(ls ~/.config/nixos);
          return 1;
        end;
        for file in $(find /etc/nixos/* | grep -ve '\.old$');
          sudo cp $file $file.$(date +%s).old;
        end;
        for file in $(find ~/.config/nixos/$argv/*);
          sudo cp $file /etc/nixos/
        end;
        nixos-up
      '';
      nixos-dump = ''
        if count $argv > /dev/null;
          :;
        else
          echo Enter the name of a NixOS config to dump to.;
          return 1;
        end;
        mkdir -p ~/.config/nixos/$argv
        for file in $(find /etc/nixos/* | grep -ve '\.old$');
          cp $file ~/.config/nixos/$argv/;
        end;
      '';
      nixos-gc = "sudo nix-collect-garbage && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      nix-gc = "nix-collect-garbage -d";
      full-gc = "nixos-gc && nix-gc";
      ga = "git add $argv";
      gr = "git restore $argv";
      gc = "git commit -m \"$argv\"";
      gp = "git push";
      gs = "git status";
      gd = "git diff \"$argv\"";
      nt = "terminal & disown";
      chx = "chmod +x \"$argv\"";
      poweroff = "systemctl poweroff --no-wall";
      reboot = "systemctl reboot -i --no-wall";
      bash = "BASH_BYPASS=1 /${pkgs.bashInteractive}/bin/bash";
    };
  };
}
