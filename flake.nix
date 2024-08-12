{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
    let 
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      packages.x86_64-linux.default = pkgs.stdenvNoCC.mkDerivation {
        src = ./src;
        name = "nd_submodule_test_sm";
        version = "0.0";
        doBuild = false;
        installPhase = ''
          install -D ./binary_in_submodule.sh $out/bin/run_me.sh
        '';
      };
      devShells.x86_64-linux.default = pkgs.mkShellNoCC {
        packages = [ self.packages.x86_64-linux.default ];
      };
  };
}
