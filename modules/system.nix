{ config, pkgs, options, ... }:

{
  imports = [
    ./i18n.nix
    ./python.nix
    ./system/editor.nix
  ];

  nix.buildCores = 0;

  # Set your time zone.
  time.timeZone = "Europe/London";
  #services.tzupdate.enable = true;
  networking.timeServers = options.networking.timeServers.default ++ [ "time.cloudflare.com" ];


  nix.gc = {
    automatic = true;
    dates = "monthly";
    options = "--delete-older-than 60d";
  };

  nix.optimise = {
    automatic = true;
    dates = ["03:15"];
  };

  services.locate = {
    enable = true;
    locate = pkgs.mlocate;
    interval = "hourly";
  };

  programs.zsh = {
    enable = true;
    promptInit = "";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    psmisc
    htop
    gotop
    cifs-utils

    unstable.inxi

    wget
    gitAndTools.gitFull
    gitAndTools.git-bug
    ripgrep
    fd
    ranger
    zsh
    tree
    unstable.buck

    fzf
    peco

    gnupg

    direnv
    unstable.go
    #nim
    rustup

    gotools
    nmap
    jq

    protobuf

    unzip

    nix-index


    libqalculate

    dnsutils
    whois

    openssl

    nix-bundle

    ntfs3g
    ntfsprogs

    google-cloud-sdk
    kubectl
    kubectx
  ];
}
