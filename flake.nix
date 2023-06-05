{
  description = "Template for EPFL (BSc, MSc, or doctoral) theses and semester projects";

  outputs = inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        # To import a flake module
        # 1. Add foo to inputs
        # 2. Add foo as a parameter to the outputs function
        # 3. Add here: foo.flakeModule

      ];
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        # Per-system attributes can be defined here. The self' and inputs'
        # module parameters provide easy access to attributes of the same
        # system.

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            texlive.combined.scheme-full

            gnumake
            rubber
          ];
        };

        packages.default = pkgs.stdenv.mkDerivation {
          name = "report";
          src = ./.;
          buildInputs = with pkgs; [
            texlive.combined.scheme-full
            rubber
          ];
          installPhase = ''
            install *.pdf -Dt $out
          '';
        };
      };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.
      };
    };
}
