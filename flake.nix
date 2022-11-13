{
  description = "A collection of (partial) nix flakes.";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = inputs: with inputs; 
    inputs.flake-utils.lib.eachDefaultSystem (system: 
      let 
        pkgs = import nixpkgs {
          inherit system;
        };
      in rec {
        devShells.rust = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            cargo-audit
            cargo-auditable

            cargo-edit
            cargo-expand
          ];
        };
      }
    );
}
