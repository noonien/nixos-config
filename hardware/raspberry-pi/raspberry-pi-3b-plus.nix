{ config, pkgs, ... }:

{
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  boot.kernelParams = [ "cma=32M" ];

  # wireless
  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [
    (pkgs.stdenv.mkDerivation {
      name = "broadcom-rpi3-extra";
      src = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/RPi-Distro/firmware-nonfree/54bab3d/brcm80211/brcm/brcmfmac43430-sdio.txt";
        sha256 = "19bmdd7w0xzybfassn7x4rb30l70vynnw3c80nlapna2k57xwbw7";
      };
      phases = [ "installPhase" ];
      installPhase = ''
        mkdir -p $out/lib/firmware/brcm
        cp $src $out/lib/firmware/brcm/brcmfmac43430-sdio.txt
      '';
    })
  ];
}
