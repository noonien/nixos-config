{ ... }:

#
# This file describes the "custom hardware" that is `cletus`.
# It is meant to be included in the machine's import just as quirks
# for common pre-built machines are.
#
# `cletus` is based on an ASUS P5N7A-VM, with a modded bios allowing
# the Xeon CPU to be fully used.
#
#   * Intel® Xeon® CPU E5440
#   * Onboard GeForce 9300
#
# And an assortment of miscellaneous unimportant parts.
#

{
  imports = [
    ../../hardware/asus/ux501vw.nix
  ];
}
