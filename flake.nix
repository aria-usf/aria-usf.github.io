{
  description = "Official site for ARIA";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=master";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        inherit (import nixpkgs { inherit system; })
          gnumake
          haunt
          mkShell
          stdenvNoCC
          ;
      in
      {
        devShells.default = mkShell {
          packages = [
            gnumake
            haunt
          ];
        };

        packages.default = stdenvNoCC.mkDerivation {
          name = "aria";
          src = ./.;

          strictDeps = true;

          nativeBuildInputs = [ haunt ];

          installPhase = ''
            runHook preInstall

            mkdir "$out"
            cp --recursive site "$out"

            runHook postInstall
          '';
        };
      }
    );
}
