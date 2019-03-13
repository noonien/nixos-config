{ config, pkgs, ... }:

{
  imports = [
    ./apps.nix
    ./desktop-environment.nix
  ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

}
