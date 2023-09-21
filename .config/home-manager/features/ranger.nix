{ pkgs, user, ... }:
let
  # TODO: update this when ranger 1.9.4 releases
  ranger = (pkgs.ranger.overrideAttrs (old: {
    version = "git";
    src = pkgs.fetchFromGitHub {
      owner = "ranger";
      repo = "ranger";
      rev = "136416c7e2ecc27315fe2354ecadfe09202df7dd";
      sha256= "sha256-nW4KlatugmPRPXl+XvV0/mo+DE5o8FLRrsJuiKbFGyY=";
    };
    buildInputs = with pkgs.python3Packages; [ 
      astroid
	    pylint
    ];
  }));
in
{
  home.file = {
    ".config/ranger/scope.sh".source = ../files/ranger/scope.sh;
    ".config/ranger/rc.conf".text = ''
      set preview_images true
      set preview_images_method sixel
      set preview_files true
      set use_preview_script true
      set preview_script ${user.home}/.config/ranger/scope.sh
      copymap <UP>    i
      copymap <DOWN>  k
      copymap <LEFT>  j
      copymap <RIGHT> l
    '';
  };
  home.packages = with pkgs; [
    ranger
  ];
}
