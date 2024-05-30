{
  description = "Logos and boot splash for ExpidusOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        inherit (pkgs) lib;
      in {
        packages.default = pkgs.stdenvNoCC.mkDerivation {
          pname = "expidus-artwork";
          version = "git+${self.shortRev or "dirty"}";

          src = lib.cleanSource self;

          nativeBuildInputs = with pkgs; [
            imagemagick
          ];

          makeFlags = [
            "DESTDIR=${placeholder "out"}"
            "prefix="
          ];
        };

        devShells.default = pkgs.mkShell rec {
          inherit (self.packages.${system}.default) pname name version;

          inputsFrom = [ self.packages.${system}.default ];
        };
      });
}
