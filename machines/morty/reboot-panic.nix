{ ... }:

{
  # sometimes we can't manually respond to a panic, just reboot.
  boot.kernelParams = [
   "panic=1" "boot.panic_on_fail"
  ];
}
