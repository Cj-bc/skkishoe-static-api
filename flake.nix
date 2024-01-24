{
  description = "Static API for skkishoe";

  outputs = { self, nixpkgs }:
  let system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${system};
  in {

    packages.${system} = let
		skk-jisyo-base = pkgs.stdenv.mkDerivation {
            name = "skk-JISYO-base";
            src = pkgs.fetchzip {
                url = "https://skk-dev.github.io/dict/SKK-JISYO.L.gz";
                hash = "sha256-GqJ3stBaDONzHGtE3l4ixITQcRXY8MTYuM2a6QevRhM=";
            };
            buildPhase = ''
            mv SKK-JISYO.L $out
            '';
    in {
        skk-jisyo-L = skk-jisyo-base.overrideAttrs {
            name = "skk-JISYO.L";
            src = pkgs.fetchzip {
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
	        src = pkgs.fetchFromGitHub {
    	        owner = "Cj-bc";
        	    repo = "skkishoe-static-api";
        	    rev = "25da7d1b6d7b33901d03ff812749759b209217f4";
        	    hash = "sha256-IBu3nzUrXOcBi8TSkthNxHUAycKETMn+9rRiKAHfQzE=";
	        };
    	    nativeBuildInputs = [pkgs.nkf pkgs.git self.packages.${system}.skk-dict];
    	    buildPhase = ''
    	    DST=$out make build
     	    '';
        };
    	default = self.packages.x86_64-linux.skkishoe-static-api;
    };
  };
}
