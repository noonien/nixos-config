{ config, pkgs, ... }:

{
  hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        libvdpau-va-gl
        vaapiVdpau
      ];
      s3tcSupport = true;
  };

  services.xserver.useGlamor = true;
  services.xserver.videoDrivers = [ "nvidia" ];
}
