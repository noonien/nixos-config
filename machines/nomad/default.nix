{ config, pkgs, ... }:
{
  imports = [
    ../../overlays

    ./hardware-configuration.nix
    ./custom-hardware.nix

    ../../modules/boot.nix
    ../../modules/zfs.nix

    ../../modules/users.nix

    ../../modules/system.nix
    ../../modules/desktop

    ../../modules/network.nix
    ../../modules/audio.nix
    ../../modules/bluetooth.nix

    ../../modules/docker.nix
  ];

  networking.hostName = "nomad"; # Define your hostname.
  networking.hostId = "2BDA01B0";

  services.openssh.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}

#{ config, pkgs, ... }:
#
#{
#  # Default state, plus hardware configurations.
#  imports = [
#    ./hardware-configuration.nix
#    ./custom-hardware.nix
#    ../../profiles/server.nix
#
#    ../../modules/containers-bridge.nix
#    ../../modules/development.nix
#    ../../modules/libvirt.nix
#    ../../modules/munin.nix
#    ./services/http.nix
#    ./services/transmission.nix
#  ];
#
#  # Name of this machine.
#  networking.hostName = "cletus";
#
#  # The NixOS release to be compatible with for stateful data such as databases.
#  system.stateVersion = "17.03";
#
#  boot.kernelPackages = pkgs.linuxPackages_4_14;
#
#  networking.nat = {
#    externalInterface = "enp0s10";
#  };
#
#  services.wakeonlan.interfaces = [
#    {
#      interface = "enp0s10";
#      method = "magicpacket";
#    } 
#  ];
#
#  # Boot as mbr
#  zr.boot.efi = false;
#  # Define on which hard drive you want to install Grub.
#  zr.boot.device = "/dev/disk/by-id/ata-WDC_WD5001AALS-00L3B2_WD-WCASY6986843";
#
#  # Ports necessary for software listed here
#  networking.firewall.allowedTCPPorts = [
#    #5900 # vnc
#    5201 # iperf
#  ];
#}
