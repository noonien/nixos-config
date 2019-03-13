{ config, pkgs, ... }:

{
  users.mutableUsers = false;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.george = {
    isNormalUser = true;

    uid = 1000;
    #shell = pkgs.zsh;

    hashedPassword = "password goes here";

    extraGroups = [
      "adm" # monitoring, logs
      "audio" # use audio devices
      "dialout" # serial
      "networkmanager" # change network settings
      "systemctl-journal" # use journalctl
      "wheel" # sudo
      "wireshark" # use wireshark
    ];
  };
}
