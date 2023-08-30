{ pkgs, ... }:
{
  users.users.christian = {
    isNormalUser = true;
    description = "Christian Smith";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
}
