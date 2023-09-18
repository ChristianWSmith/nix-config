{ pkgs, ... }:
{
  programs.fish.enable = true;
  users.users.christian = {
    isNormalUser = true;
    description = "Christian Smith";
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" ];
<<<<<<< HEAD
    packages = with pkgs; [];
    shell = pkgs.fish;
=======
    shell = pkgs.fish;
  };
  services.xserver.displayManager.autoLogin = {
    user = "christian";
    enable = true;  
>>>>>>> main
  };
  programs.fish.enable = true;
}
