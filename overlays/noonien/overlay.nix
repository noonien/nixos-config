self: super:

let inherit (self) callPackage fetchFromGitHub fetchurl;
in
{
  unstable = import <nixos-unstable> { config = self.config; };

  fetchGitHubFiles = callPackage ./pkgs/build-support/fetchgithubfiles { };
  fetchMultiURLs = callPackage ./pkgs/build-support/fetchmultiurls { };

  nerdfonts = callPackage ./pkgs/nerdfonts { };
  nordnm = callPackage ./pkgs/tools/networking/nordnm { };

  gnome3 = super.gnome3.overrideScope' (gself: gsuper: {
    vte-ng = gsuper.vte-ng.overrideAttrs (old: {
      patches = [ ./patches/vte-ng/background-colors-alpha.patch ];
    });
  });

  wpgtk = self.unstable.wpgtk.overrideAttrs (old: rec {
    version = "6.0.1";
    src = fetchFromGitHub {
      owner = "deviantfero";
      repo = "wpgtk";
      rev = "${version}";
      sha256 = "1g85lpp3zscdvr8akrzwkpsd5y8n2b10rwx0prw40b4fkqjvr8vy";
    };
  });

  ghidra-bin = self.unstable.ghidra-bin.overrideAttrs (old: rec {
	src = fetchurl {
	  url = https://ghidra-sre.org/ghidra_9.0.4_PUBLIC_20190516.zip;
	  sha256 = "1gqqxk57hswwgr97qisqivcfgjdxjipfdshyh4r76dyrfpa0q3d5";
	};
  });

  nim = self.unstable.nim.overrideAttrs (old: rec {
    name = "nim-${version}";
    version = "devel";
    src = fetchurl {
      url = "https://github.com/nim-lang/nightlies/releases/download/2019-10-27-devel-3a62cf2/nim-1.0.99-osx.tar.xz";
      sha256 = "1n74vxmfkr8xa36j07jzi639m9vrhhw90pcvxmf9708fwaw6cg43";
    };
    prePatch = "";
    patchPhase = "";
    checkPhase = "";
  });
}
