{ pkgs, user, theme, ... }:
{
  home.packages = with pkgs; [ eza ];
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting

      if test (tty) = /dev/tty1;
        while test -f ~/.tty1-gui-only;
          hyprland-launcher;
        end;
      end;
      
      set fish_color_autosuggestion ${theme.colorScheme.background4Hex}
      set fish_color_cancel \x2d\x2dreverse
      set fish_color_command ${theme.colorScheme.successHex}
      set fish_color_comment ${theme.colorScheme.warningHex}
      set fish_color_end ${theme.colorScheme.specialHex}
      set fish_color_error ${theme.colorScheme.dangerHex}
      set fish_color_escape ${theme.colorScheme.accentHex}
      set fish_color_host_remote \x1d
      set fish_color_keyword \x1d
      set fish_color_match ${theme.colorScheme.infoHex}
      set fish_color_operator ${theme.colorScheme.infoHex}
      set fish_color_option \x1d
      set fish_color_param ${theme.colorScheme.foreground3Hex}
      set fish_color_quote ${theme.colorScheme.warningHex}
      set fish_color_redirection ${theme.colorScheme.foreground3Hex}
      set fish_pager_color_background \x1d
      set fish_pager_color_description ${theme.colorScheme.warningHex}
      set fish_pager_color_secondary_background \x1d
      set fish_pager_color_secondary_completion \x1d
      set fish_pager_color_secondary_description \x1d
      set fish_pager_color_secondary_prefix \x1d
      set fish_pager_color_selected_background \x2d\x2dbackground\x3dbrblack
      set fish_pager_color_selected_completion \x1d
      set fish_pager_color_selected_description \x1d
      set fish_pager_color_selected_prefix \x1d

      alias ls "eza --icons"
      alias nix-gc "nix-collect-garbage -d"
      alias full-gc "nixos-gc && nix-gc"
      alias ga "git add"
      alias gr "git restore"
      alias gc "git commit -m"
      alias gp "git push"
      alias gs "git status"
      alias gd "git diff"
      alias nt "terminal & disown"
      alias chx "chmod +x"
      alias chw "chmod +w"
      alias poweroff "systemctl poweroff --no-wall"
      alias reboot "systemctl reboot -i --no-wall"
    '';

    functions = {
      fish_prompt = ''
        set -l last_pipestatus $pipestatus
        set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

        if not set -q __fish_git_prompt_show_informative_status
            set -g __fish_git_prompt_show_informative_status 1
        end
        if not set -q __fish_git_prompt_hide_untrackedfiles
            set -g __fish_git_prompt_hide_untrackedfiles 1
        end
        if not set -q __fish_git_prompt_color_branch
            set -g __fish_git_prompt_color_branch ${theme.colorScheme.specialHex} --bold
        end
        if not set -q __fish_git_prompt_showupstream
            set -g __fish_git_prompt_showupstream informative
        end
        if not set -q __fish_git_prompt_color_dirtystate
            set -g __fish_git_prompt_color_dirtystate ${theme.colorScheme.infoHex}
        end
        if not set -q __fish_git_prompt_color_stagedstate
            set -g __fish_git_prompt_color_stagedstate ${theme.colorScheme.warningHex}
        end
        if not set -q __fish_git_prompt_color_invalidstate
            set -g __fish_git_prompt_color_invalidstate ${theme.colorScheme.dangerHex}
        end
        if not set -q __fish_git_prompt_color_untrackedfiles
            set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
        end
        if not set -q __fish_git_prompt_color_cleanstate
            set -g __fish_git_prompt_color_cleanstate ${theme.colorScheme.successHex} --bold
        end

        set -l color_cwd
        set -l suffix
        if functions -q fish_is_root_user; and fish_is_root_user
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end
            set suffix '#'
        else
            set color_cwd $fish_color_cwd
            set suffix '$'
        end

        # PWD
        set_color $color_cwd
        echo -n (prompt_pwd)
        set_color normal

        printf '%s ' (fish_vcs_prompt)

        set -l status_color (set_color $fish_color_status)
        set -l statusb_color (set_color --bold $fish_color_status)
        set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)
        echo -n $prompt_status
        set_color normal

        echo -n "$suffix "
      '';
      nixos-up = ''
        if ! test "$argv"
          echo "Usage: nixos-up <machine_profile> (flake)"
          return
        end
        sudo nix-channel --update
        cp -r ${user.home}/.config/nixos /tmp
        if test "$argv[2]" = "flake"
          echo "updating flake.lock..."
          nix flake update /tmp/nixos/
        end
        sudo nixos-rebuild switch --flake /tmp/nixos/#$argv[1]
        if test "$argv[2]" = "flake"
          cp /tmp/nixos/flake.lock ${user.home}/.config/nixos/flake.lock
        end
        rm -rf /tmp/nixos
      '';
      nix-up = ''
        if test "$argv[1]" = "flake"
          echo "updating flake.lock..."
          nix flake update ${user.home}/.config/home-manager/
        end
        pushd $(pwd)
        nix-channel --update
        home-manager switch -b backup
        popd
      '';
      nixos-gc = ''
        sudo nix-collect-garbage
        sudo nix-collect-garbage -d
        sudo /run/current-system/bin/switch-to-configuration boot
      '';
      nix-goto = "cd $(dirname $(readlink -f $(which $argv)))";
    };
  };
}
