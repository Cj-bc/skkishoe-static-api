{
  description = "Static API for skkishoe";

  outputs = { self, nixpkgs }:
  let system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${system};
  in {

    packages.${system} = {
        skk-dict = pkgs.stdenv.mkDerivation {
            name = "skk-JISYO.L";
            src = pkgs.fetchzip {
                url = "https://skk-dev.github.io/dict/SKK-JISYO.L.gz";
                hash = "sha256-GqJ3stBaDONzHGtE3l4ixITQcRXY8MTYuM2a6QevRhM=";
            };
            buildPhase = ''
            mv skk-JISYO.L $out
            ''
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
        };
    	default = self.packages.x86_64-linux.skkishoe-static-api;
    };
  };
}
