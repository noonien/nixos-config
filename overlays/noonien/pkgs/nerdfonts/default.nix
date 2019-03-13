{ lib, pkgs, stdenvNoCC, python3, ttfautohint, symlinkJoin }:

let
  srcs = pkgs.callPackage ./srcs.nix {};
  fontpatcher = stdenvNoCC.mkDerivation rec {
    name = "nerdfonts-patcher-${srcs.version}";

    src = srcs.font-patcher;

    phases = [ "unpackPhase" "buildPhase" "installPhase" "fixupPhase" ];
    propagatedBuildInputs = [
      (python3.withPackages (ps: with ps; [ fontforge fonttools configparser ]))
      ttfautohint
    ];

    buildPhase = ''
      substituteInPlace font-patcher \
        --replace '__dir__+"/src/glyphs/"' "\"$out/share/nerdfonts/glyphs/\""
    '';

    installPhase = ''
      install -m 755 -D font-patcher $out/bin/nerdfonts-patcher
      install -m 644 -D src/glyphs/* -t $out/share/nerdfonts/glyphs/
    '';
  };
  defaultOptions = {
    mono = true;
    fontawesome = true;
    fontawesomeextension = true;
    fontlinux = true;
    octicons = true;
    powersymbols = true;
    pomicons = true;
    powerline = true;
    powerlineextra = true;
    material = true;
    weather = true;
    removeligatures = true;
  };
  createFont = {name, src}: stdenvNoCC.mkDerivation ({
	name = "nerdfonts-${lib.toLower name}-${srcs.version}";
    inherit src;

    phases = [ "unpackPhase" "buildPhase" ];
    nativeBuildInputs = [ fontpatcher ];

    buildPhase = ''
      if [ -d 'bin' ]; then
        patchShebangs bin/
      fi

      if [ "${name}" == "Noto" ]; then
        rm src/unpatched-fonts/Noto/Emoji/NotoColorEmoji.ttf
      fi

      params=
      for arg in "${builtins.concatStringsSep "\" \"" (builtins.attrNames defaultOptions)}"; do
        [ -n "''${!arg}" ] && params+=" --$arg"
      done

      find . -iname '*.[o,t]tf' -type f -print0 |
          while IFS= read -d $'\0' -r font; do
              header "patching $font"

              config_dir=''${font%/*}
              config_parent_dir=''${config_dir%/*}

              # source the font config file if exists:
              if [ -f "$config_dir/config.cfg" ]; then
                  source "$config_dir/config.cfg"
              elif [ -f "$config_parent_dir/config.cfg" ]; then
                  source "$config_parent_dir/config.cfg"
              fi

              [ -f "$config_parent_dir/config.json" ] && [ -n $removeligatures ] && \
                  params+=" --removeligatures --configfile $config_parent_dir/config.json"

              [ -n "$post_process" ] && params+=" --postprocess=$post_process"

              ext=''${font: -4}
              [ "''${ext,,}" == ".ttf" ] && font_type=truetype || font_type=opentype

              out_dir=$out/share/fonts/$font_type
              mkdir -p $out_dir

              nerdfonts-patcher "$font" -q --no-progressbars $params --outputdir "$out_dir" 2>/dev/null
          done
    '';

  } // defaultOptions);
  fonts = builtins.listToAttrs (map (font: { name = (lib.toLower font.name); value = createFont font; }) srcs.fonts);

in
symlinkJoin {
  name = "nerdfonts";
  paths = builtins.attrValues fonts;
} // fonts
