{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;

    # enable touchpad support
    libinput.enable = true;

    displayManager.lightdm = {
      enable = true;
      autoLogin.enable = true;
      autoLogin.user = "george";
    };

    desktopManager = {
      default = "none";
      xterm.enable = false;
    };

    windowManager.default = "i3";
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };

  programs.dconf.enable = true;
  services.dbus.packages = [ pkgs.gnome3.dconf ];

  services.gnome3.gnome-keyring.enable = true;
  # Not necessary, but helpful for checking if the keyring is named correctly
  # (we expect "login"), and that it is unlocked.
  programs.seahorse.enable = true;

  services.redshift = {
    enable = true;
  };
  location.provider = "geoclue2";

  services.compton = {
    enable = true;
    refreshRate = 60;
  };

  fonts.fonts = with pkgs; [
    #nerdfonts
    #nerdfonts.noto
    nerdfonts.anonymouspro
    emojione
    font-awesome
    unifont
    siji
  ];

  gtk.iconCache.enable = true;

  environment.variables = {
    # need for pcmanfs gvfs
    GIO_EXTRA_MODULES = [ "${pkgs.gvfs}/lib/gio/modules" ];
  };

  programs.ssh = {
    askPassword = "${pkgs.lxqt.lxqt-openssh-askpass}/bin/lxqt-openssh-askpass";
  };

  programs.nm-applet.enable = true;
  systemd.user.services = {
    udiskie = {
      description = "Automounter for removable media";

      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.udiskie}/bin/udiskie --no-automount --tray --use-udisks2";
        Restart = "always";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # we use this for get-active-cwd.sh
    xorg.xdpyinfo
    xdotool

    compton
    termite
    alacritty

    dunst
    libnotify

    networkmanagerapplet

    (polybar.override {
      #inherit curl  mpd_clientlib  libpulseaudio wirelesstools libnl jsoncpp;

      githubSupport = true;
      mpdSupport = true;
      pulseSupport = true;
      #iwSupport = true;
      nlSupport = true;
      i3GapsSupport = true;
    })

    partition-manager

    rofi
    pcmanfm
    gvfs

    kleopatra

    arandr

    gnome3.file-roller
    gnome3.gnome-font-viewer

    arc-theme
    arc-icon-theme

    numix-gtk-theme
    numix-icon-theme
  ];

}
