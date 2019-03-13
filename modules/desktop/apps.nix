{ config, pkgs, ... }:

{
  imports = [
    ./apps/steam.nix
    #./apps/vscode.nix
  ];

  environment.systemPackages = with pkgs; [

    # browsers
    unstable.brave
    google-chrome
    firefox
    #torbrowser

    # media players
    vlc
    smplayer
    mpv

    wpgtk
    rambox
    electrum
    android-file-transfer
    libreoffice
    transmission-gtk
    gthumb
    recordmydesktop
    scrot
    qalculate-gtk
    unstable.mindforger
    ghidra-bin
    remmina
    partition-manager

    gnome3.zenity # used by vim color picker to spawn gui popups
  ];

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
}
