{ pkgs, ... }:
{
  programs.fish.enable = true;
  users.users.christian = {
    isNormalUser = true;
    description = "Christian Smith";
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" ];
    shell = pkgs.fish;
  };
  services.xserver.displayManager.autoLogin = {
    user = "christian";
    enable = true;  
  };
}
