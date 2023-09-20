{ pkgs, ... }:
{
  home.file = {
    ".config/ranger/rc.conf".text = ''
      set preview_images true
      set preview_images_method ueberzug
      set preview_files true
    '';
  };
  home.packages = with pkgs; [
    ranger
    ueberzugpp
  ];
}
