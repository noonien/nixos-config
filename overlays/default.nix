{
  # Tracked overlays
  imports = [
    ./noonien
  ]

  # Untracked / local overlays.
  ++ (if (builtins.pathExists(./default.local.nix)) then [ ./default.local.nix ] else []);
}
