{ niv, gitAndTools, callPackage }:

let
  tools = callPackage ./tools.nix {};
in
  tools // rec {
  inherit niv;
  inherit (gitAndTools) pre-commit;
  run = callPackage ./run.nix { inherit tools; };

  # A pre-commit-check for nix-pre-commit itself
  pre-commit-check = run {
    src = ../.;
    hooks = {
      shellcheck.enable = true;
      canonix.enable = true;
    };
    excludes = [
      "nix/sources.nix$"
    ];
  };
}
