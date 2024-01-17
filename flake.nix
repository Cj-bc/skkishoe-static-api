{
  description = "Static API for skkishoe";

  outputs = { self, nixpkgs }:
  let system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${system};
  in {

    packages.${system} = {
        skkishoe-static-api = pkgs.stdenv.mkDerivation {
        	name = "skkishoe-static-api";
	        src = pkgs.fetchFromGitHub {
    	        owner = "Cj-bc";
        	    repo = "skkishoe-static-api";
        	    rev = "25da7d1b6d7b33901d03ff812749759b209217f4";
        	    hash = "sha256-IBu3nzUrXOcBi8TSkthNxHUAycKETMn+9rRiKAHfQzE=";
	        };
    	    nativeBuildInputs = [pkgs.nkf pkgs.git];
        };
    	default = self.packages.x86_64-linux.skkishoe-static-api;
    };
  };
}
