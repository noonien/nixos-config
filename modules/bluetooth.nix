{ config, pkgs, ... }:

{
  hardware = {
    bluetooth = {
      enable = true;
      extraConfig = ''
        [General]
        Enable=Source,Sink,Media,Socket
      '';
    };

    pulseaudio = {
      package = pkgs.pulseaudioFull;
    };
  };

  environment.systemPackages = with pkgs; [
    blueman
  ];
}
