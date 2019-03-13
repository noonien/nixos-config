# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # enable UEFI
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 1;

  # timeout systemd jobs
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=30s
  '';


  # latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # LUKS device
  boot.initrd.luks.devices."root".device = "/dev/disk/by-uuid/<uuid goes here>";

  # zfs
  boot.supportedFilesystems = [ "zfs" ];

  # Enable Plymouth
  boot.plymouth.enable = true;

 # Clear /tmp on boot
 boot.cleanTmpDir = true;
}
