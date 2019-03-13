{ config, pkgs, ... }:

{
  # Audio configuration
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
  };

  #hardware.pulseaudio.tcp.enable = true;
  #hardware.pulseaudio.zeroconf.discovery.enable = true;
  #hardware.pulseaudio.zeroconf.publish.enable = true;

  environment.systemPackages = with pkgs; [
    pavucontrol
    paprefs
  ];
}
