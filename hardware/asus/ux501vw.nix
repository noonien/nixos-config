{ config, pkgs, ... }:

{
  imports = [
    #../profiles/laptop.nix
    ../cpu/intel.nix
    #../gpu/intel.nix
    ../gpu/nvidia-forceon.nix
  ];

  boot.kernelParams = [
    "intel_idle.max_cstate=1"

    # https://wiki.archlinux.org/index.php/ASUS_Zenbook_Pro_UX501#Module_Configuration
    "acpi_osi=!"
    "acpi_osi=\"Windows 2009\""
    "acpi_backlight=native"
  ];
  boot.blacklistedKernelModules = [ "nouveau" ];
  boot.extraModprobeConfig = ''
    # fix headphone noise
    options snd-hda-intel power_save=0 power_save_controller=N

    # enable power-saving for intel graphics
    options i915 enable_rc6=1 enable_fbc=1 lvds_downclock=1 semaphores=1
  '';

  # variable fan control
  boot.kernelModules = [ "coretemp" ];
  environment.systemPackages = with pkgs; [ lm_sensors ];
}
