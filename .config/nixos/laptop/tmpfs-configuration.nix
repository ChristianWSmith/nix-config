{
  fileSystems."/ram" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "size=1M" "mode=777" ];
  };
}
