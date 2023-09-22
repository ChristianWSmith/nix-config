{ pkgs, user, ... }:
{
  home.packages = [ pkgs.mpc-cli ];
  programs.ncmpcpp = {
    enable = true;
    mpdMusicDir = "${user.home}/Music";
    # package = pkgs.ncmpcpp;
    # bindings = [];
    # settings = {};
  };
  services.mpd = {
    enable = true;
    musicDirectory = "${user.home}/Music";
    # package = pkgs.mpd;
    # dataDir = ;
    # dbFile = ;
    # extraArgs = [];
    # extraConfig = "";
    # network = {
    #   listenAddress = ;
    #   port = ;
    # };
  };
}
