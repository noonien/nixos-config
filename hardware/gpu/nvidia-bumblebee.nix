{ config, pkgs, ... }:
{
  imports = [
    ./nvidia.nix
  ];

  hardware.bumblebee.enable = true;
  environment.systemPackages = with pkgs; [ primus ];
}
