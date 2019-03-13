{ config, ... }:

{
  boot.kernelParams = [ "zfs.zfs_arc_max=5368709120" ];
  services.zfs.autoScrub.enable = true;
  services.zfs.autoSnapshot.enable = true;
}
