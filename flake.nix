{
  description = "Static API for skkishoe";

  outputs = { self, nixpkgs }:
  let system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${system};
  in {

    packages.${system} = let
		skk-jisyo-base = pkgs.stdenv.mkDerivation {
            name = "skk-JISYO-base";
            src = pkgs.fetchurl {
                url = "https://skk-dev.github.io/dict/SKK-JISYO.L.gz";
                hash = "sha256-GqJ3stBaDONzHGtE3l4ixITQcRXY8MTYuM2a6QevRhM=";
            };
            nativeBuildInputs = [ pkgs.gzip ];
            phases = "unpackPhase installPhase";
            unpackPhase = ''
            	runHook preUnpack
				cp $src $(stripHash "$src")
				find . -name 'SKK-JISYO.*.gz' -exec gunzip {} \+
            	runHook postUnpack
            '';
            installPhase = ''
            d="$out/usr/share/skk"
            mkdir -p $d
            mv SKK-JISYO.* $d/
            '';
      };
    in {
        skk-jisyo-L = skk-jisyo-base.overrideAttrs {
            name = "skk-JISYO.L";
            src = pkgs.fetchurl {
                url = "https://skk-dev.github.io/dict/SKK-JISYO.L.gz";
                hash = "sha256-GqJ3stBaDONzHGtE3l4ixITQcRXY8MTYuM2a6QevRhM=";
            };
        };
        skk-jisyo-S = skk-jisyo-base.overrideAttrs {
            name = "skk-JISYO.S";
            pname = "skk-JISYO.S";
            src = pkgs.fetchurl {
                url = "https://skk-dev.github.io/dict/SKK-JISYO.S.gz";
                hash = "sha256-NJ++BzYZ0eWknENU6ZQ1UpLt4Ivi+z5scUgXdRFAXsI=";
            };
        };
        skkishoe-static-api = pkgs.stdenv.mkDerivation {
        	name = "skkishoe-static-api";
	        src = ./.;
    	    nativeBuildInputs = [pkgs.nkf self.packages.${system}.skk-jisyo-S];
    	    buildPhase = ''
    	    DST=$out make build
     	    '';
        };
    	default = self.packages.x86_64-linux.skkishoe-static-api;
    };
  };
}
