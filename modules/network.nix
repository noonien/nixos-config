{ config, pkgs, ... }:

{
  networking.networkmanager = {
    enable = true;
    packages = with pkgs; [
      networkmanager_openvpn
    ];
  };

  environment.systemPackages = with pkgs; [
    nordnm
  ];

  networking.firewall.enable = false;
}
