{ inputs, ... }:
{
  imports = [ inputs.make-shell.flakeModules.default ];

  perSystem =
    {
      pkgs,
      lib,
      ...
    }:
    let
      typst = pkgs.typst.withPackages (p: [
        p.fontawesome
      ]);

      typst-fonts = pkgs.symlinkJoin {
        name = "typst-fonts";
        paths = with pkgs; [
          font-awesome
          roboto
          newcomputermodern
        ];
      };

      mkTypstScript =
        action: documentPath: root: withGitCommitId:
        pkgs.writeShellApplication {
          name = "typst-${action}-${
            builtins.replaceStrings [ "/" ] [ "-" ] (lib.removePrefix "src/" documentPath)
          }";

          runtimeInputs = [
            typst
            pkgs.gitMinimal
          ];

          text = ''
            GIT_SHORT_COMMIT_ID=""
            GIT_SHORT_COMMIT_ID_RAW=""
            # shellcheck disable=SC2050
            if [ "${toString withGitCommitId}" = "1" ]; then
                GIT_SHORT_COMMIT_ID_RAW=$(git rev-parse --short HEAD)
                if [ -n "$GIT_SHORT_COMMIT_ID_RAW" ]; then
                    GIT_SHORT_COMMIT_ID="-$GIT_SHORT_COMMIT_ID_RAW"
                fi
            fi

            export GIT_SHORT_COMMIT_ID

            ${lib.getExe typst} \
              ${action} \
              --root ${root} \
              --input rev="${inputs.self.rev or "$GIT_SHORT_COMMIT_ID_RAW"}" \
              --input shortRev="${inputs.self.shortRev or "$GIT_SHORT_COMMIT_ID_RAW"}" \
              --input builddate="$(date -u)" \
              --font-path ${typst-fonts} \
              --ignore-system-fonts \
              ${documentPath}/main.typ \
              ${
                builtins.replaceStrings [ "/" ] [ "-" ] (
                  lib.removePrefix "${root}/src/" (lib.removePrefix "src/" documentPath)
                )
              }"$GIT_SHORT_COMMIT_ID".pdf
          '';
        };

      mkBuildDocumentDrv =
        action: documentPath:
        pkgs.stdenvNoCC.mkDerivation (finalAttrs: {
          pname = "typst-${action}-${builtins.replaceStrings [ "/" ] [ "-" ] (toString documentPath)}";
          version = "0.0.1";

          src = pkgs.lib.cleanSource ../..;

          buildInputs = [ typst ];

          buildPhase = ''
            runHook preBuild

            ${lib.getExe (
              mkTypstScript "compile" (
                (toString finalAttrs.src) + "/" + (toString documentPath)
              ) (toString finalAttrs.src) false
            )}

            runHook postBuild
          '';

          installPhase = ''
            runHook preInstall

            install -m640 -D ${
              builtins.replaceStrings [ "/" ] [ "-" ] (lib.removePrefix "src/" documentPath)
            }.* -t $out

            runHook postInstall
          '';
        });

      # Find all files recursively in the source directory
      allFiles = lib.filesystem.listFilesRecursive ../../src;

      # Filter the list to keep only files named "main.typ"
      mainTypFiles = lib.filter (path: lib.strings.hasSuffix "/main.typ" (toString path)) allFiles;

      # Get the parent directory of each "main.typ" file and ensure uniqueness
      documentDirs = lib.unique (map (path: builtins.dirOf path) mainTypFiles);

      # Create a list of directory names relative to the ../../src directory
      # e.g., from /nix/store/...-source/src/a/b -> a/b
      relativeDocDirs = map (dir: lib.removePrefix "${toString ../..}/" (toString dir)) documentDirs;

      documentDrvs = lib.foldl (
        a: path:
        a
        // {
          "${builtins.replaceStrings [ "/" ] [ "-" ] (lib.removePrefix "src/" path)}" = (
            mkBuildDocumentDrv "compile" path
          );
        }
      ) { } relativeDocDirs;

      scriptDrvs = lib.foldl (
        a: path:
        a
        // {
          # "${builtins.replaceStrings [ "/" ] [ "-" ] path}" = (mkBuildDocumentDrv "compile" path);
          "compile-${builtins.replaceStrings [ "/" ] [ "-" ] path}" = (
            mkTypstScript "compile" (toString path) "./." true
          );
          "watch-${builtins.replaceStrings [ "/" ] [ "-" ] path}" = (
            mkTypstScript "watch" (toString path) "./." false
          );
        }
      ) { } relativeDocDirs;
    in
    {
      packages = documentDrvs;

      make-shells.default = {
        packages = [
          typst
          pkgs.typstyle
        ]
        ++ lib.attrValues scriptDrvs;
        env = {
          TYPST_PACKAGE_PATH = "${typst}/lib/typst/packages";
          # This is only for VSCode rendering
          TYPST_FONT_PATHS = "${typst-fonts}";
        };
      };
    };
}
