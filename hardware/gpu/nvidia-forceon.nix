{ config, pkgs, ... }:
{
  imports = [
    ./nvidia.nix
  ];

  hardware.nvidia.optimus_prime = {
    enable = true;
    # Bus ID of the NVIDIA GPU. You can find it using lspci
    nvidiaBusId = "PCI:1:0:0";
    # Bus ID of the Intel GPU. You can find it using lspci
    intelBusId = "PCI:0:2:0";
  };
}
