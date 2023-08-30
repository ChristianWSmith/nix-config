{ pkgs, ... }:
{
  boot.initrd.kernelModules = [ "amdgpu" ];
  # To enforce HIP
  # systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.hip}" ];
  hardware.opengl = {
    extraPackages = with pkgs; [ rocm-opencl-icd rocm-opencl-runtime amdvlk ];
    extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    driSupport = true;
    driSupport32Bit = true;
  };
}
