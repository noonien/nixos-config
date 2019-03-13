{ config, pkgs, ... }:
{
 nixpkgs.config.allowUnfree = true;
 virtualisation.virtualbox.host = {
   enable = true;
   enableExtensionPack = true;
   package = pkgs.unstable.virtualbox;
 };

 users.extraGroups.vboxusers.members = [ "george" ];
}
