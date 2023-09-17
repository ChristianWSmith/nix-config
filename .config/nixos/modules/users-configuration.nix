{ pkgs, ... }:
{
  users.users.christian = {
    isNormalUser = true;
    description = "Christian Smith";
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };
  programs.fish.enable = true;
}
