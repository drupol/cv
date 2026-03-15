{
  # Define the inputs for the flake.
  inputs = {
    # Provides the large `nixpkgs` package set.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # flake-parts helps structure the flake outputs.
    flake-parts.url = "github:hercules-ci/flake-parts";
    # import-tree helps to import all Nix files from a directory.
    import-tree.url = "github:vic/import-tree";
    # make-shell provides utilities to create development shells more declaratively.
    make-shell.url = "github:nicknovitski/make-shell";
    # treefmt-nix provides formatting for all the project files.
    treefmt-nix.url = "github:numtide/treefmt-nix";
    # Make it compatible with legacy nix commands
    flake-compat = {
      url = "github:NixOS/flake-compat";
      flake = false;
    };
  };

  # The outputs function defines what this flake provides.
  # Its sole parameter is `inputs`, which contains the resolved inputs.
  outputs =
    inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./nix/modules);
}
