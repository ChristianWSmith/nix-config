{ pkgs, ... }:
{
  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.opengl = {
    extraPackages = with pkgs; [ rocm-opencl-icd rocm-opencl-runtime amdvlk ];
    extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    driSupport = true;
    driSupport32Bit = true;
  };
}
