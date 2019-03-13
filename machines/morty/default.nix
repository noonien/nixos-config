# Provide a basic configuration for installation devices like CDs.
{ config, pkgs, lib, ... }:

{
  imports = [
    ../../overlays

    ./hardware-configuration.nix
    ../../hardware/raspberry-pi-foundation/raspberry-pi-3b-plus.nix

    ../../profiles/raspberry-pi.nix
  ];

  # Name of this machine.
  networking.hostName = "morty";

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "18.09";

  boot.kernelPackages = pkgs.unstable.linuxPackages_latest;

  # no X
  environment.noXlibs = true;

  # This isn't perfect, but let's expect the user specifies an UTF-8 defaultLocale
  i18n.supportedLocales = [ (config.i18n.defaultLocale + "/UTF-8") ];

  # don't need documentation
  documentation.enable = false;
  documentation.man.enable = false;
  documentation.info.enable = false;
  documentation.doc.enable = false;

  # Disable some other stuff we don't need.
  security.sudo.enable = false;
  services.udisks2.enable = false;

  # Allow sshd to be started manually through "systemctl start sshd".
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };

  networking.wireless = {
    enable = true;
    networks = {
      "VodafoneConnect59087453" = {
        pskRaw = "42ed8f081447bdc9c8e2ec647a488770602a03804e19dee0887b6ea6b001277b";
      };
    };
  };

  networking.firewall.enable = false;
  services.home-assistant = {
    enable = true;
    package = pkgs.unstable.home-assistant;
  };
}
