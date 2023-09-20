{ pkgs, ... }:
{
  home.file = {
    ".config/ranger/rc.conf".text = ''
      set preview_images true
      set preview_images_method kitty
      set preview_files true
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
