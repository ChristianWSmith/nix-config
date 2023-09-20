{ pkgs, lib, ... }:
{
  home.file = {
    ".config/ranger/rc.conf".text = ''
      set preview_images true
      set preview_images_method sixel
      set preview_files true
      copymap <UP>    i
      copymap <DOWN>  k
      copymap <LEFT>  j
      copymap <RIGHT> l
    '';
  };
  home.packages = with pkgs; [
    (pkgs.ranger.overrideAttrs (old: {
      version = "git";
      src = fetchFromGitHub {
        owner = "ranger";
        repo = "ranger";
        rev = "136416c7e2ecc27315fe2354ecadfe09202df7dd";
        sha256= "sha256-nW4KlatugmPRPXl+XvV0/mo+DE5o8FLRrsJuiKbFGyY=";
      };
      buildInputs = with python3Packages; [ 
        astroid
	pylint
      ];
    }))
  ];
}
