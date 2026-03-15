{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem =
    { lib, pkgs, ... }:
    {
      treefmt = {
        projectRootFile = "flake.nix";
        programs = {
          deadnix.enable = true;
          nixfmt.enable = true;
          ruff.enable = true;
          yamlfmt.enable = true;
          prettier.enable = true;
          typstyle.enable = true;
        };
        settings = {
          no-cache = true;
          formatter = {
            bibtex-tidy = {
              command = "${lib.getExe pkgs.bibtex-tidy}";
              includes = [ "*.bib" ];
            };
            prettier = {
              options = [
                "--prose-wrap=always"
              ];
              tabWidth = 2;
              editorconfig = true;
            };
            markdown-code-runner = {
              command = lib.getExe pkgs.markdown-code-runner;
              options = [
                "--check"
                "--config=${
                  pkgs.writers.writeTOML "markdown-code-runner-config" {
                    presets = {
                      nixfmt = {
                        language = "nix";
                        command = [ (lib.getExe pkgs.nixfmt) ];
                      };
                      plantuml = {
                        language = "puml";
                        command = [
                          (lib.getExe pkgs.plantuml)
                          "-checkonly"
                          "-failfast"
                          "-p"
                        ];
                        output_mode = "check";
                      };
                      graphviz = {
                        language = "dot";
                        command = [
                          "${pkgs.graphviz}/bin/dot"
                        ];
                        output_mode = "check";
                      };
                    };
                  }
                }"
              ];
              includes = [ "*.md" ];
            };
          };
          on-unmatched = "warn";
        };
      };
    };
}
