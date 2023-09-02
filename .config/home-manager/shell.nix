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
      nixos-up = ''
        if ! test "$argv"
	  echo "Usage: nixos-up <machine_profile> (flake)"
	  return
	end
        sudo nix-channel --update
	cp -r ${userHome}/.config/nixos /tmp
	if test "$argv[2]" = "flake"
	  echo "updating flake.lock..."
          nix flake update /tmp/nixos/
	end
	sudo nixos-rebuild switch --flake /tmp/nixos/#$argv[1]
	if test "$argv[2]" = "flake"
          cp /tmp/nixos/flake.lock ${userHome}/.config/nixos/flake.lock
	end
	rm -rf /tmp/nixos
      '';
      nix-up = ''
        if test "$argv[1]" = "flake"
	  echo "updating flake.lock..."
          nix flake update ${userHome}/.config/home-manager/
	end
        pushd $(pwd)
	nix-channel --update
	home-manager switch -b backup --impure
	popd
      '';
      nixos-gc = ''
        sudo nix-collect-garbage
	sudo nix-collect-garbage -d
	sudo /run/current-system/bin/switch-to-configuration boot
      '';
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
      nix-goto = "cd $(dirname $(readlink -f $(which $argv)))";
      poweroff = "systemctl poweroff --no-wall";
      reboot = "systemctl reboot -i --no-wall";
      bash = "BASH_BYPASS=1 /${pkgs.bashInteractive}/bin/bash";
    };
  };
}
