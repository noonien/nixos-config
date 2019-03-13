{
  # Imports `module.nix` if present, which is expected to add to
  # the nixos configuration system.
  #imports =  [ ./module.nix ];

  # Imports the overlay
  nixpkgs.overlays = [
    (import ./overlay.nix)
  ];
}
