{ pkgs, user, ... }:
{
  home.packages = with pkgs; [ mpc-cli mpdevil ];
  programs.ncmpcpp = {
    enable = true;
    mpdMusicDir = "${user.home}/Music";
  };
  services.mpd = {
    enable = true;
    musicDirectory = "${user.home}/Music";
  };
}
