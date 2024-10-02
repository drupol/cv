{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      perSystem =
        { pkgs, config, ... }:
        let
          tex = pkgs.texlive.combine { inherit (pkgs.texlive) scheme-full latex-bin latexmk; };
        in
        {
          devShells.default = pkgs.mkShellNoCC {
            packages = [
              pkgs.coreutils
              tex
              pkgs.gnumake
            ];
          };

          packages.default = pkgs.stdenvNoCC.mkDerivation {
            pname = "cv-short";
            version = self.shortRev or self.lastModifiedDate;
            src = self;
            buildInputs = [
              pkgs.coreutils
              tex
              pkgs.gnumake
            ];
            configurePhase = ''
              runHook preConfigure
              substituteInPlace "src/cv/version.tex" \
                --replace-fail "dev" "${config.packages.default.version}"
              runHook postConfigure
            '';
            installPhase = ''
              runHook preInstall
              mkdir -p $out
              cp build/cv.pdf $out/
              runHook postInstall
            '';
          };
        };
    };
}
