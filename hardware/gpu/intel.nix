{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Sometimes needed on new hardware for backlight control.
    xorg.xbacklight
    xorg.xf86videointel
  ];

  hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiIntel
        libGL_driver.drivers
      ];
      s3tcSupport = true;
  };

  services.xserver = {
    videoDrivers = [ "intel" ];
    useGlamor = true;
    deviceSection = ''
      Option "DRI" "2"
      Option "TearFree" "True"
    '';
  };
}
