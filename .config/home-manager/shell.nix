{ pkgs, user, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      yafetch
    '';
    functions = {
      nixos-up = ''
        sudo nix-channel --update
        cp -r ${user.home}/.config/nixos /tmp
        if test "$argv[1]" = "flake"
        echo "updating flake.lock..."
          nix flake update /tmp/nixos/
        end
        sudo nixos-rebuild switch --flake /tmp/nixos/#default
        if test "$argv[1]" = "flake"
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
  home.file = {
    ".config/fish/fish_variables".text = ''
      # This file contains fish universal variable definitions.
      # VERSION: 3.0
      SETUVAR __fish_initialized:3400
      SETUVAR fish_color_autosuggestion:4c566a
      SETUVAR fish_color_cancel:\x2d\x2dreverse
      SETUVAR fish_color_command:81a1c1
      SETUVAR fish_color_comment:434c5e
      SETUVAR fish_color_cwd:green
      SETUVAR fish_color_cwd_root:red
      SETUVAR fish_color_end:88c0d0
      SETUVAR fish_color_error:ebcb8b
      SETUVAR fish_color_escape:00a6b2
      SETUVAR fish_color_history_current:\x2d\x2dbold
      SETUVAR fish_color_host:normal
      SETUVAR fish_color_host_remote:\x1d
      SETUVAR fish_color_keyword:\x1d
      SETUVAR fish_color_match:\x2d\x2dbackground\x3dbrblue
      SETUVAR fish_color_normal:normal
      SETUVAR fish_color_operator:00a6b2
      SETUVAR fish_color_option:\x1d
      SETUVAR fish_color_param:eceff4
      SETUVAR fish_color_quote:a3be8c
      SETUVAR fish_color_redirection:b48ead
      SETUVAR fish_color_search_match:bryellow\x1e\x2d\x2dbackground\x3dbrblack
      SETUVAR fish_color_selection:white\x1e\x2d\x2dbold\x1e\x2d\x2dbackground\x3dbrblack
      SETUVAR fish_color_status:red
      SETUVAR fish_color_user:brgreen
      SETUVAR fish_color_valid_path:\x2d\x2dunderline
      SETUVAR fish_key_bindings:fish_default_key_bindings
      SETUVAR fish_pager_color_background:\x1d
      SETUVAR fish_pager_color_completion:normal
      SETUVAR fish_pager_color_description:B3A06D
      SETUVAR fish_pager_color_prefix:normal\x1e\x2d\x2dbold\x1e\x2d\x2dunderline
      SETUVAR fish_pager_color_progress:brwhite\x1e\x2d\x2dbackground\x3dcyan
      SETUVAR fish_pager_color_secondary_background:\x1d
      SETUVAR fish_pager_color_secondary_completion:\x1d
      SETUVAR fish_pager_color_secondary_description:\x1d
      SETUVAR fish_pager_color_secondary_prefix:\x1d
      SETUVAR fish_pager_color_selected_background:\x2d\x2dbackground\x3dbrblack
      SETUVAR fish_pager_color_selected_completion:\x1d
      SETUVAR fish_pager_color_selected_description:\x1d
      SETUVAR fish_pager_color_selected_prefix:\x1d
    '';
  };
}
