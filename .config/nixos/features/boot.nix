{ pkgs, ... }:
{
  boot = {
    consoleLogLevel = 0;
    initrd = {
      verbose = false;
      systemd.dbus.enable = true;
    };
    plymouth = {
      enable = true;
      themePackages = [ (pkgs.callPackage ./nixsur-plymouth-theme/default.nix {}) ];
      theme = "nixsur";
    };
    kernelParams = [ "nowatchdog" "audit=0" "modprobe.blacklist=sp5100_tco" "loglevel=3" "reboot=bios" "quiet" "splash" "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3" "boot.shell_on_fail" "vt.global_cursor_default=0" ];
    loader =
    {
      timeout = 0;
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };
}
