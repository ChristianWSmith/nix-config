{ pkgs, ...}:
{
  home.packages = [ pkgs.gtklock ];
  home.file = {
    ".config/gtklock/style.css".text = ''
      window {
        background-image: url("../../.active-wallpaper");
        background-size: 100% 100%;
      }
    '';
  };
}
