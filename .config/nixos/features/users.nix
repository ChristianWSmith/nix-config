{ pkgs, ... }:
{
  users.users.christian = {
    isNormalUser = true;
    description = "Christian Smith";
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" ];
  };
  services.xserver.displayManager.autoLogin = {
    user = "christian";
    enable = true;  
  };
}
