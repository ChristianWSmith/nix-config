{ pkgs, userHome, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    functions = {
      nixos-up = ''
        sudo nix-channel --update
        cp -r ${userHome}/.config/nixos /tmp
        if test "$argv[1]" = "flake"
        echo "updating flake.lock..."
          nix flake update /tmp/nixos/
        end
        sudo nixos-rebuild switch --flake /tmp/nixos/#default
        if test "$argv[1]" = "flake"
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
      full-up = ''
        nixos-up "$argv"
	nix-up "$argv"
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
      chx = "chmod +x \"$argv\"";
      chw = "chmod +w \"$argv\"";
      nix-goto = "cd $(dirname $(readlink -f $(which $argv)))";
    };
  };
}
